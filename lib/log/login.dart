// ignore_for_file: sort_child_properties_last

import 'package:dart_boysfishing/constants.dart';
import 'package:dart_boysfishing/log/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dart_boysfishing/mainbar.dart';
import 'package:dart_boysfishing/constants.dart';
import 'register.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
 
  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c_LogoDarkColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 120)),
              Center(
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  width: 170.0,
                ),
              ),
              Form(
                child: Theme(
                data: ThemeData(
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Color.fromARGB(255, 164, 163, 163), 
                      fontSize: 15.0, 
                      fontWeight: FontWeight.bold,),
                    )),
                child: Container(
                  //color: Colors.white,
                  padding: EdgeInsets.all(40.0),
                  child: Builder(builder: (context) {
                    return Column(
                      children: [
                        TextField(
                          controller: controller,
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 11, 0, 9),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Enter email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: controller2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 11, 0, 9),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Enter password'
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                                style: TextStyle(
                                  color: c_LogoBrightColor,
                                  fontSize: 15,
                                ),
                              recognizer: TapGestureRecognizer()
                              ..onTap = _ToRegister,
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: _ToHome,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                  backgroundColor: Color.fromARGB(255, 51, 195, 235)),
                            ))
                      ],
                    );
                  })),
              )),
              
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _ToHome() async {
    if (controller.text == 'asdf@gmail.com' && controller2.text == '1234') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainBar()));
    }
    else if (controller.text == 'asdf@gmail.com' && controller2.text != '1234') {
      showSnackBar(context, Text('Wrong password'));
    }
    else if (controller.text != 'asdf@gmail.com' && controller2.text == '1234') {
      showSnackBar(context, Text('Wrong email'));
    }
    else {
      showSnackBar(context, Text('Check your info again'));
    }
  }

  Future<void> _ToRegister() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
