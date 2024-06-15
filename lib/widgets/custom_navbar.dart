import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homeScreen');
                  },
                  icon: Image.asset(
                    'images/house.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Image.asset(
                    'images/shopping-cart.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profilPage');
                  },
                  icon: Image.asset(
                    'images/user.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Çıkış Yap"),
                          content:
                              Text("Çıkış yapmak istediğinizden emin misiniz?"),
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
                  icon: Image.asset(
                    'images/log-out.png',
                    width: 32,
                    height: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
