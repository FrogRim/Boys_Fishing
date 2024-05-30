import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:dart_boysfishing/constants.dart';
import 'package:dart_boysfishing/log/login.dart';
import 'my_session.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});
 
  @override
  State<MyPage> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyPage> {
  final String sMemberName = 'asdf';
  final String sMemberEmail = 'asdf@example.com';
  final int iSessionPassTotal = 20;
  final int iSessionPassCurrent = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c_ContainerDarkColor,
      appBar: AppBar(
        title: Text('마이페이지', style: s_AppBarFontstyle),
        backgroundColor: c_AppBarColor,
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(d_ContainerPadding),
              color: c_ContainerBrightColor,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _MemberName(nickname: sMemberName, id: sMemberEmail)
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: double.infinity,
                    //height: 200,
                    decoration: BoxDecoration(
                      color: c_ContainerBrightColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: Offset(1, 12)
                      )]
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(d_ContainerPadding),
                          child: _SessionPass(total: iSessionPassTotal, current: iSessionPassCurrent),                          
                        )
                      ]
                    )
                  ),
                  ElevatedButton(
                    child: Text('Logout'),
                    onPressed: () async { 
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ]
              )
            ),
            
          ],
        ),
      )
    );
  }

  Future<void> _ToSessionPass() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SessionPage()));
  }
}

Widget _MemberName({required String nickname, required String id}) {
  return Text.rich(
    textAlign: TextAlign.left,
    TextSpan(
      children: [
        TextSpan(
          text: nickname,
          style: s_H1Fontstyle,
        ),
        TextSpan(
          text: ' 님, 안녕하세요!',
          style: s_H2Fontstyle
        ),
        TextSpan(
          text: '\n' + id,
          style: s_H3Fontstyle
        ),
      ],
    ),
  );
}

Widget _SessionPass({required int total, required int current}) {
  return Row(
    children: <Widget>[CircularStepProgressIndicator(
        totalSteps: total,
        currentStep: current,
        stepSize: 30,
        padding: pi / 80,
        width: 120,
        height: 120,
        startingAngle: 0,
        arcSize: pi * 2 / 3 * 2,
        gradientColor: LinearGradient(colors: [Colors.blue, Colors.purple])
      ),
      SizedBox(
        width: 15.0,
      ),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '진척도',
              style: s_H1Fontstyle,
            ),
            TextSpan(
              text: 'd',
              style: s_H2Fontstyle
            )
          ],
        ),
      )
    ]
  );
}