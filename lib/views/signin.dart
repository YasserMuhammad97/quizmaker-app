import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signup.dart';
import 'package:quizmaker/widgets/widget.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signInWithEmailAndPass(email, password,context).then((value) {
        if (value != null) {
          HelperFuncitons.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Email ID" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? "Enter Password" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: blueButton(context: context , label: 'Sign In'),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 15.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
