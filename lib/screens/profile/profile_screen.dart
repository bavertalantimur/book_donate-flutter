import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/widgets/profile_text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> editField(String field) async {
    String newValue = "";
    bool isPassword = field == 'password';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit ${isPassword ? 'password' : field}",
          style: TextStyle(color: Colors.white),
        ),
        content: isPassword
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter current password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter new password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Confirm new password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              )
            : TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) {
                  newValue = value;
                },
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (isPassword) {
                String currentPassword = _passwordController.text.trim();
                String newPassword = _newPasswordController.text.trim();
                String confirmPassword = _confirmPasswordController.text.trim();

                if (currentPassword.isEmpty ||
                    newPassword.isEmpty ||
                    confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("All fields are required"),
                  ));
                  return;
                }

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Passwords do not match"),
                  ));
                  return;
                }

                try {
                  // Reauthenticate user with current password
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: currentUser.email!,
                    password: currentPassword,
                  );
                  await currentUser.reauthenticateWithCredential(credential);

                  // Update password in Firebase Authentication
                  await currentUser.updatePassword(newPassword);

                  // Update password in Firestore
                  await userCollection
                      .doc(currentUser.email)
                      .update({'password': newPassword});

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Password updated successfully"),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Failed to update password. Please check your current password and try again."),
                  ));
                }
              } else {
                if (newValue.trim().isNotEmpty) {
                  try {
                    await userCollection
                        .doc(currentUser.email)
                        .update({field: newValue});
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Failed to update $field. Please try again."),
                    ));
                  }
                }
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 10),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                ProfileTextBox(
                  text: userData['name'],
                  name: 'name',
                  onPressed: () => editField('name'),
                ),
                ProfileTextBox(
                  text: userData['lastname'],
                  name: 'lastname',
                  onPressed: () => editField('lastname'),
                ),
                ProfileTextBox(
                  text: userData[
                      'password'], // Just for indication that password is hidden
                  name: 'password',
                  onPressed: () => editField('password'),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
