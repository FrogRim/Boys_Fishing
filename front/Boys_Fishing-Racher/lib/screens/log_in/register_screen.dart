import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // JSON 인코딩/디코딩을 위해 필요

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
             TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Register button pressed");
                registerUser(context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    var url = Uri.parse('http://10.0.2.2:8000/accounts/register/');  // Django 백엔드 API URL
    print('Request sent to $url');
    int init_season_pass_progress = 0;
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
      },
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
        'name' : _nameController.text,
        'season_pass_progress' : init_season_pass_progress,
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print('Registration successful');
      Navigator.pop(context);  // 성공적으로 등록 후 이전 화면으로 돌아감
    } else {
      print('Failed to register: ${response.body}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content: Text('Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
