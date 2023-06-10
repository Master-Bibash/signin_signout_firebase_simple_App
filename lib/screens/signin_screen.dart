import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signinoutfirebase/reusable/tectfireld_reusable.dart'
    as reusable;
import 'package:signinoutfirebase/screens/home_screen.dart';
import 'package:signinoutfirebase/screens/signout_screen.dart';
import 'package:signinoutfirebase/utils/colors_utils.dart';

import '../reusable/tectfireld_reusable.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("Cb2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoWidget("assets/images/logo.png"),
            SizedBox(height: 30),
            reusable.reusableTextField(
              "Enter UserName",
              Icons.person_2_outlined,
              false,
              _emailTextController,
            ),
            SizedBox(height: 20),
            reusable.reusableTextField(
              "Enter Password",
              Icons.lock,
              true,
              _passwordTextController,
            ),
            SizedBox(height: 20),
            signInSignUpButton(context, false, () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                  .then((value) {
                print("Signed in"); // Add this line
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }).catchError((error) {
                print("Error signing in: ${error.toString()}");
              });
            }),
            signupOption(context),
          ],
        ),
      ),
    );
  }

  Image logoWidget(String imageName) {
    return Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: 200,
      color: Colors.white,
    );
  }
}

Row signupOption(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have an account",
        style: TextStyle(color: Colors.white70),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignOutScreen(),
            ),
          );
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
