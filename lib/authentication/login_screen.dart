

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatod_users_app/authentication/signup_screen.dart';

import '../Global/global.dart';
import '../splashscreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();


  validateForm() {
    if (!emailtextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not corrected",
          backgroundColor: Colors.red);
    }
    else if (passwordtextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is mandatory",
          backgroundColor: Colors.red);
    }
    else {
      LoginUserNow();
    }
  }

  LoginUserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference userReference = FirebaseDatabase.instance.ref().child("drivers");
      userReference.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("images/logo.jpg"),
              ),
              const Text(
                "Login As A User",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E)),
              ),

              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailtextEditingController,
                style: const TextStyle(color: Color(0xFF1A237E)),
                decoration: const InputDecoration(
                  labelText: "email:",
                  hintText: "email address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFF1A237E),
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: passwordtextEditingController,
                style: const TextStyle(color: Color(0xFF1A237E)),
                decoration: const InputDecoration(
                  labelText: "password:",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFF1A237E),
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  validateForm();
                  //  Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoSceen()));

                },
                child: const Text(
                  "Login",
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF053BB3),
                ),
              ),

              TextButton(
                child: const Text('Do not have an account? Signup here',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const SignUpScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}