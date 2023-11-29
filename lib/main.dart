import 'package:flutter_test_application/home_page.dart';
import 'package:flutter_test_application/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test_application/sign_up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
