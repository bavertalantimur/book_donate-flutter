import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_test_application/widgets/widgets.dart';

class WishListScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => WishListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'WishList'),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishlistLoaded) {
            return GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 2.2),
              itemCount: state.wishList.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ProductCard(
                    product: state.wishList.products[index],
                    widthFactor: 1.8,
                    leftPosition: 50,
                    isWishList: true,
                  ),
                );
              },
            );
          } else {
            return const Text('Sometgin went wrong');
          }
        },
      ),
    );
  }
}
