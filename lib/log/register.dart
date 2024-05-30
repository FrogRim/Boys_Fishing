import 'package:dart_boysfishing/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dart_boysfishing/constants.dart';
import 'login.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
 
  @override
  State<RegisterPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPage> {
  TextEditingController controller_name = TextEditingController();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_password = TextEditingController();
  TextEditingController controller_pwtest = TextEditingController();

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
              Padding(padding: EdgeInsets.only(top: 110)),
              Center(
                child: Image(
                  image: AssetImage('assets/logo_notext.png'),
                  width: 160.0,
                ),
              ),
              Form(
                child: Theme(
                data: ThemeData(
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(
                        hintStyle: TextStyle(color: Color.fromARGB(255, 121, 121, 121), fontSize: 15.0),
                        counterStyle: TextStyle(color: Colors.white)
                        )),
                child: Container(
                  //color: Colors.white,
                  padding: EdgeInsets.all(40.0),
                  child: Builder(builder: (context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: controller_name,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your name',
                            counterText: 'NAME'
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: controller_email,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, size: 20),
                            contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'ID@example.com',
                            counterText: 'EMAIL ADDRESS'
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextField(
                          controller: controller_password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, size: 21),
                            contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter password',
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: controller_pwtest,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, size: 21),
                            contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter password',
                            counterText: 'PASSWORD'
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: _ToLogin,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                  backgroundColor: c_LogoBrightColor),
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
  
  Future<void> _ToLogin() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}