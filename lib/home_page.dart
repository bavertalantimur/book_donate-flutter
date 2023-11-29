import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, "/loginPage"),
          child: Text(
            "Giriş Sayfasına Geri Dön",
            style: TextStyle(color: Colors.pink[300]),
          ),
        ),
      ),
    );
  }
}
