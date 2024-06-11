import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  final int redirectPage; // 로그인 후 리다이렉트할 페이지 인덱스
  const LoginPage({super.key, required this.redirectPage});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // 비밀번호 가시성 상태
  bool _rememberMe = false; // "기억하기" 체크박스 상태

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSignUp = false; // 회원가입 폼 여부

  // 회원가입 폼 필드
  final TextEditingController _nameController = TextEditingController();
  String _gender = '남'; // 성별 필드
  DateTime _dob = DateTime.now(); // 생년월일 필드

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      Navigator.of(context).pop(widget.redirectPage); // 이미 로그인된 경우 리다이렉트
    }
  }
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600; // 작은 화면 여부 판단

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _Logo(),
                  _gap(),
                  _buildFormContent(), // FormContent 대신 직접 빌드
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    const Expanded(child: _Logo()),
                    Expanded(
                      child: Center(child: _buildFormContent()), // FormContent 대신 직접 빌드
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // 로그인 또는 회원가입 폼 내용 빌드
  Widget _buildFormContent() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isSignUp) ...[
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              _gap(),
              _buildGenderField(),
              _gap(),
              _buildDobField(),
              _gap(),
            ],
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),
            if (!_isSignUp)
              CheckboxListTile(
                value: _rememberMe,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _rememberMe = value;
                  });
                },
                title: const Text('Remember me'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                contentPadding: const EdgeInsets.all(0),
              ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    _isSignUp ? 'Sign up' : 'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: _isSignUp ? _signUp : _login,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                });
              },
              child: Text(
                _isSignUp ? 'Already have an account? Sign in' : 'Don\'t have an account? Sign up',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16); // 간격 위젯

  void _login() async {
  if (_formKey.currentState?.validate() ?? false) {
    final requestBody = jsonEncode({
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    print('Request body: $requestBody'); // 요청 본문 출력

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/accounts/api/token/'),  // Django 서버 URL 확인
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}'); // 응답 상태 코드 출력
    print('Response body: ${response.body}'); // 응답 본문 출력

    if (response.statusCode == 200) {
      // 로그인 성공 시
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      await prefs.setString('access_token', data['access']);
      await prefs.setString('refresh_token', data['refresh']);

      // 로그인 후 이전 페이지로 리다이렉트
      Navigator.of(context).pop(widget.redirectPage);
    } else {
      // 로그인 실패 시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/accounts/register/'),
        body: jsonEncode({
          'name': _nameController.text,
          'username': _usernameController.text,
          'password': _passwordController.text,
          'gender': _gender,
          'dob': "${_dob.toLocal()}".split(' ')[0],
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 201) {
        // 회원가입 성공 시
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Successful'),
              content: const Text('Your account has been created.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      _isSignUp = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // 회원가입 실패 시
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Failed'),
              content: const Text('There was an error creating your account.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  // 성별 선택 필드
  Widget _buildGenderField() {
    return Row(
      children: [
        const Text('Gender:'),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Man'),
            value: 'Man',
            groupValue: _gender,
            onChanged: (value) {
              setState(() {
                _gender = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Woman'),
            value: 'Woman',
            groupValue: _gender,
            onChanged: (value) {
              setState(() {
                _gender = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  // 생년월일 선택 필드
  Widget _buildDobField() {
    return Row(
      children: [
        const Text('Date of Birth:'),
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _dob,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != _dob) {
              setState(() {
                _dob = picked;
              });
            }
          },
          child: Text(
            "${_dob.toLocal()}".split(' ')[0],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}

// 로고 클래스
class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       
        //FlutterLogo(size: isSmallScreen ? 100 : 200),
        Image.asset(
          'assets/images/logo.png',  // 이미지 경로
          width: isSmallScreen ? 100 : 200,  // 작은 화면과 큰 화면에서 이미지 크기 조절
          height: isSmallScreen ? 100 : 200, // 이미지의 높이 설정
          fit: BoxFit.cover, // 이미지가 위젯 영역에 맞게 조절됨
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "BOY'S FISHING!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}