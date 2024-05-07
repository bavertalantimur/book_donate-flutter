import 'package:flutter/material.dart';
import 'package:flutter_test_application/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'H O M E ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  'P R O F I L E',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  'L O G E O U T',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}





/*import 'package:flutter/material.dart';
import 'package:flutter_test_application/screens/card/card_screen.dart';
import 'package:flutter_test_application/widgets/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  const MyDrawer({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CardScreen()));
                },
              ),
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G E O U T',
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}*/
