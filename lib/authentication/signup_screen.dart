import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatod_users_app/authentication/login_screen.dart';
import 'package:hatod_users_app/splashscreen/splash_screen.dart';

import '../Global/global.dart';
import '../widgets/progress_dialog.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

 validateForm() {
   if (nametextEditingController.text.length < 3) {
     Fluttertoast.showToast(msg: "Don't use short forms write correct name",
         backgroundColor: Colors.red);
   }

   else if (!emailtextEditingController.text.contains("@")) {
     Fluttertoast.showToast(msg: "Email is not corrected",
         backgroundColor: Colors.red);
   }

   else if (phonetextEditingController.text.isEmpty) {
     Fluttertoast.showToast(msg: "Phone number is mandatory",
         backgroundColor: Colors.red);
   }
   else if (passwordtextEditingController.text.length < 6) {
     Fluttertoast.showToast(msg: "password must be atleast 6 characters",
         backgroundColor: Colors.red);
   }
   else{
           saveUserInfoNow();
     }
 }

  saveUserInfoNow() async
 {
   showDialog(
     context: context,
     barrierDismissible: false,
     builder: (BuildContext c ){
       return ProgressDialog(message: "Processing,please wait...");
     }
   );

   final User? firebaseUser = (

       await fAuth.createUserWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
         password: passwordtextEditingController.text.trim(),
       ).catchError((msg){

         Navigator.pop(context);
         Fluttertoast.showToast(msg: "error:"+msg.toString());
       })
   ).user;


   if(firebaseUser != null){

      Map userMap=
          {
            "id":firebaseUser.uid,
            "name": nametextEditingController.text.trim(),
            "email":emailtextEditingController.text.trim(),
            "phone":phonetextEditingController.text.trim(),
          };

      DatabaseReference driversRef =FirebaseDatabase.instance.ref().child("users");
      driversRef.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

   }

   else{

     Navigator.pop(context);
     Fluttertoast.showToast(msg: "Account has not been Created");
   }
 }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /*  const SizedBox(
                height: 20,
              ),*/
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, bottom: 2, left: 20),
                child: Image.asset("images/logo.jpg"),
              ),
              /*const SizedBox(
                height: 20,
              ),*/
              const Text(
                "Register As A User",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E)),
              ),
              TextField(
                controller: nametextEditingController,
                style: const TextStyle(color: Color(0xFF1A237E)),
                decoration: const InputDecoration(
                  labelText: "name:",
                  hintText: "Name",
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
                keyboardType: TextInputType.phone,
                controller: phonetextEditingController,
                style: const TextStyle(color: Color(0xFF1A237E)),
                decoration: const InputDecoration(
                  labelText: "mobile:",
                  hintText: "mobile number",
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
                },

                child: const Text(
                  "Create an account",
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF053BB3),
                ),
              ),
              TextButton(
                child: const Text('Already have an account ? Login here',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                  ),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
