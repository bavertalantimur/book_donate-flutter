import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_application/blocs/cart/cart_bloc.dart';
import 'package:flutter_test_application/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_test_application/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_test_application/config/app_router.dart';
import 'package:flutter_test_application/forgot_pw_page.dart';
import 'package:flutter_test_application/home_page.dart';
import 'package:flutter_test_application/login_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test_application/repositories/checkout/checkout_repository.dart';
import 'package:flutter_test_application/screens/screens.dart';
import 'package:flutter_test_application/sign_up.dart';
import 'blocs/category/category_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/category/category_repository.dart';
import 'repositories/product/product_repository.dart';

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
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
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
