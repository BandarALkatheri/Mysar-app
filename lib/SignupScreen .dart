import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskyfinaly/common/customTextFiled.dart';
import 'package:taskyfinaly/common/custom_button.dart';
import 'package:taskyfinaly/common/showErrorSnackBar.dart';
import 'package:taskyfinaly/LoginScreen.dart';
import 'dart:core';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  bool isloading = false;

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
                        child: Image.asset(
                            'assets/logo/logoapp.png'), // تأكد من أن المسار صحيح
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        "أنشاء حساب",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // انتقل إلى صفحة إنشاء حساب جديد
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'قم بتسجيل الدخول  ',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.orange,
                                  fontFamily: 'Helvetica'),
                            ),
                          ),
                          const Text(
                            'لديك حساب بالفعل قم',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      /*
                      const SizedBox(height: 30),
                           
                      customTextFiled(
                        labltext: '  الاسم'.toString(),
                        iconData: Icons.person_2_outlined,
                      ),
                  
                      */
                      const SizedBox(height: 20),
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
                        iconData: Icons.lock_clock_outlined,
                      ),

                      const SizedBox(height: 20),
                      custom_Button(
                        text: isloading ? "جاري انشاء حساب" : '  انشاء حساب ',
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          if (formstate.currentState!.validate()) {
                            try {
                              UserCredential user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email!, password: password!);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showErrorSnackBar(context, 'كلمة السر ضعيفة');
                              } else if (e.code == 'email-already-in-use') {
                                showErrorSnackBar(
                                    context, 'الايميل موجود مسبقا');
                              }
                            } catch (e) {
                              print(e);
                              showErrorSnackBar(context, 'تاكد من الانترنت');
                            }
                          } else {}
                        },
                      ),

                      const SizedBox(height: 5),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'من خلال إنشاء حساب فانك توافق على الشروط والاحكام الخاصة بناء',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
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
