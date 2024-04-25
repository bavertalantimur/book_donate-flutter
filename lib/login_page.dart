import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/home_page.dart';
import 'package:flutter_test_application/screens/screens.dart';
import 'package:flutter_test_application/service/auth_service.dart';
import 'package:flutter_test_application/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;

  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0Xff21254A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topImageContainer(height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      titleText(),
                      customSizedBox(),
                      emailTextField(),
                      customSizedBox(),
                      passwrodTextField(),
                      customSizedBox(),
                      forgotPasswordButton(),
                      signInButton(),
                      customSizedBox(),
                      CustomTextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/signUp"),
                        buttonText: "Sign Up",
                      ),
                      /*
                      CustomTextButton(
                          onPressed: () async {
                            final result = await authService.signInAnonymous();
                            if (result != null) {
                              Navigator.pushNamed(context, '/homeScreen');
                            } else {
                              print("Hata ile karsilasildi");
                            }
                          },
                          buttonText: "Misafir Girisi"),
                      CustomTextButton(
                          onPressed: () async {
                            final result = await authService.signInAnonymous();
                            if (result != null) {
                              Navigator.pushNamed(context, '/adminScreen');
                            } else {
                              print("Hata ile karsilasildi");
                            }
                          },
                          buttonText: "Admin Girisi"),*/
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center AccountText() {
    return Center(
      child: Text(
        "Hesabın yok mu ?",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container topImageContainer(double height) {
    return Container(
      height: height * .25,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/topImage.png"),
        ),
      ),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/signUp"),
        child: Text(
          "Hesap Oluştur",
          style: TextStyle(color: Colors.pink[300]),
        ),
      ),
    );
  }

  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.pink[400],
          ),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

//// HomeScreen yapılacak
  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      print(email + password);
      final result = await authService.signIn(email, password);
      if (result == "success") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Hata"),
                content: Text(result!),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Geri Don"))
                ],
              );
            });
      }
    }
  }

  TextButton forgotPasswordButton() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, "/forgotPassword"),
      child: Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.pink[300]),
      ),
    );
  }

  TextFormField passwrodTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      decoration: customInputDecaration("Password"),
      style: TextStyle(color: Colors.grey[300]),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecaration("Email"),
      style: TextStyle(color: Colors.grey[300]),
    );
  }

  Text titleText() {
    return Text(
      "Hello,\nWelcome To My App",
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: 20,
      );

  InputDecoration customInputDecaration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
