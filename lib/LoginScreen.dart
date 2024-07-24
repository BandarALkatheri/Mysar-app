import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:taskyfinaly/SignupScreen%20.dart';
import 'package:taskyfinaly/bottom_navigation_screen%20.dart';
import 'package:taskyfinaly/common/customTextFiled.dart';
import 'package:taskyfinaly/common/custom_button.dart';
import 'package:taskyfinaly/common/showErrorSnackBar.dart';
import 'package:taskyfinaly/home.dart';
import 'package:taskyfinaly/resetPasword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  String? email;

  String? password;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Logo
                      SizedBox(
                        height: 200,
                        child: Image.asset('assets/logo/logoapp.png'),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'أهلا وسهلا',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'مرحبا بك معنا مجددًا، قم بتسجيل الدخول إلى حسابك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // انتقل إلى صفحة إنشاء حساب جديد
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          'قم بإنشاء حساب جديد',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange,
                              fontFamily: 'Helvetica'),
                        ),
                      ),
                      const SizedBox(height: 30),

                      customTextFiled(
                        validator: (valu) {
                          if (valu == null || valu.isEmpty) {
                            return 'Please enter an email';
                          }

                          valu = valu.replaceAll(RegExp(r'\s+'), '');
                          String pattern =
                              r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(valu)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          email = data.replaceAll(RegExp(r'\s+'), '');
                        },
                        labltext: '  الايميل'.toString(),
                        iconData: Icons.email_outlined,
                      ),
                      const SizedBox(height: 10),

                      customTextFiled(
                        isPassword: true,
                        validator: (valu) {
                          if (valu == null || valu.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (valu.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          password = data.trim();
                        },
                        labltext: '  كلمة السر'.toString(),
                        iconData: Icons.lock,
                      ),

                      const SizedBox(height: 20),
                      custom_Button(
                        text: isloading ? 'جاري تسجيل الدخول' : 'تسجيل الدخول',
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          if (formstate.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );

                              showErrorSnackBar(context, "تسجيل الدخول بنجاح.");

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        bottomNavigationScreen()), // تأكد من أن bottomNavigationScreen صحيح
                              );
                            } on FirebaseAuthException catch (e) {
                              switch (e.code) {
                                case "invalid-email":
                                  showErrorSnackBar(context, "تاكد من الايميل");
                                  break;
                                default:
                                  showErrorSnackBar(context, "لايوجد انترنت.");
                              }
                            }
                          } else {
                            showErrorSnackBar(context, "لايوجد انترنت.");
                          }
                          setState(() {
                            isloading = false;
                          });
                        },
                      ),

                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    forgetPasworrd()), // تأكد من أن HomeScreen صحيح
                          );
                        },
                        child: const Text('نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: Colors.orange,
                              fontFamily: 'Helvetica',
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
