import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aNOTHER pAGE'),
      ),
      body: Center(
        child: Text('Another Page'),
      ),
    );
  }
}
