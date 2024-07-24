import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:taskyfinaly/SignupScreen%20.dart';
import 'package:taskyfinaly/bottom_navigation_screen%20.dart';
import 'package:taskyfinaly/common/customTextFiled.dart';
import 'package:taskyfinaly/common/custom_button.dart';
import 'package:taskyfinaly/common/showErrorSnackBar.dart';
import 'package:taskyfinaly/home.dart';
import 'package:taskyfinaly/LoginScreen.dart';

class forgetPasworrd extends StatelessWidget {
  forgetPasworrd({super.key});
  String? email;

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
                        child: Image.asset(
                            'assets/logo/logoapp.png'), // تأكد من أن المسار صحيح
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'نسيت كلمه المرور',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'قم بكتابه الايميل في المربع حتى تستطيع استعادة كلمه السر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 13,
                          color: Colors.grey,
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

                      const SizedBox(height: 20),
                      custom_Button(
                          text: 'استعادة كلمه المرور',
                          onPressed: () async {
                            if (formstate.currentState!.validate()) {
                              onPressed:
                              () async {
                                final cleanedEmail =
                                    email?.replaceAll(RegExp(r'\s+'), '');

                                if (email == '') {
                                  showErrorSnackBar(context,
                                      "قم بكتابه الايميل في الحقل ومن ثم اضغط على استعاده كلمه السر.");

                                  return;
                                }

                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: cleanedEmail!);

                                  showErrorSnackBar(context,
                                      "تم ارسال تعيين كلمه السر الى الايميل الخاص بك.");
                                } catch (e) {
                                  showErrorSnackBar(
                                      context, 'الرجاء قوم بادخال ايميل صالح.');
                                }
                              };
                            }
                          }),
                      const SizedBox(height: 18),

                      GestureDetector(
                        onTap: () {
                          // انتقل إلى صفحة إنشاء حساب جديد
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'قم بتسجيل الدخول  ',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange,
                              fontFamily: 'Helvetica'),
                        ),
                      ),

                      const SizedBox(height: 18),
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
