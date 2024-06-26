import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatod_users_app/Global/global.dart';
import 'package:hatod_users_app/authentication/login_screen.dart';
import 'package:hatod_users_app/mainScreens/main_screen.dart';

import '../assistants/assistant_methods.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}


class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 3), () async
    {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.jpg"),

              const SizedBox(height: 20),

              const Text(
                "Hatod Users App",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF053BB3),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
