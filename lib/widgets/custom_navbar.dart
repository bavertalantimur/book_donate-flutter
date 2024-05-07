import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

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
                Navigator.pushNamed(context, '/profilPage');
              },
              icon: Icon(Icons.person, color: Colors.white)),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Çıkış Yap"),
                    content: Text("Çıkış yapmak istediğinizden emin misiniz?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Hayır"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, '/loginPage');
                        },
                        child: Text("Evet"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
    );
  }
}



/* import 'package:firebase_auth/firebase_auth.dart';

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
                Navigator.pushNamed(context, '/profilPage');
              },
              icon: Icon(Icons.person, color: Colors.white)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/profilPage');
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white)),
        ],
      ),
    );
  }
}
*/