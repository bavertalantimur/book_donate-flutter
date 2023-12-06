import 'package:flutter/material.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
import 'package:flutter_test_application/widgets/custom_navbar.dart';

class WishListScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => WishListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'WishList'),
      body: Center(),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
