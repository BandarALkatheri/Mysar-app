import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskyfinaly/add_pro.dart';
import 'package:taskyfinaly/firebase_options.dart';
import 'package:taskyfinaly/home.dart';
import 'package:taskyfinaly/LoginScreen.dart';
import 'package:taskyfinaly/provider/offerProvider.dart';
import 'package:taskyfinaly/bottom_navigation_screen%20.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Offerprovider();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return bottomNavigationScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
