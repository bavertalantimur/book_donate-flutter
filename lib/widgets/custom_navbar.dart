import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/service/auth_service.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homeScreen');
              },
              icon: Icon(Icons.home, color: Colors.white)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              icon: Icon(Icons.person, color: Colors.white)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                //Navigator.pushNamed(context, '/loginPage');
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white)),
        ],
      ),
    );
  }
}
