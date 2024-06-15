import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_test_application/blocs/cart/cart_bloc.dart';

import '../models/product_model.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartProductCard(
      {super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.sora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: GoogleFonts.sora(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return CircularProgressIndicator();
              }
              if (state is CartLoaded) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(CartProductRemoved(product));
                      },
                      icon: const Icon(Icons.remove_circle),
                      color: Color(0xFF8E44AD), // İkon rengi
                      splashColor: Colors.transparent, // Tıklama efekti rengi
                      highlightColor:
                          Colors.transparent, // Basılı tutma efekti rengi
                    ),
                    Text(
                      '$quantity',
                      style: GoogleFonts.sora(),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(CartProductAdded(product));
                      },
                      icon: const Icon(Icons.add_circle),
                      color: Color(0xFF8E44AD), // İkon rengi
                      splashColor: Colors.transparent, // Tıklama efekti rengi
                      highlightColor:
                          Colors.transparent, // Basılı tutma efekti rengi
                    ),
                  ],
                );
              }
              return Text(
                'Something went wrong',
                style: GoogleFonts.sora(),
              );
            },
          ),
        ],
      ),
    );
  }
}
