import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
import 'package:flutter_test_application/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),

      ///!!!!
      builder: (context) => CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
