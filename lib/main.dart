import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_application/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_test_application/config/app_router.dart';
import 'package:flutter_test_application/forgot_pw_page.dart';
import 'package:flutter_test_application/home_page.dart';
import 'package:flutter_test_application/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test_application/screens/home/home_screen.dart';
import 'package:flutter_test_application/sign_up.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishList())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          "/loginPage": (context) => LoginPage(),
          "/signUp": (context) => SignUp(),
          "/homePage": (context) => HomePage(),
          "/forgotPassword": (context) => ForgotPasswordPage(),
          "/homeScreen": (context) => HomeScreen()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
