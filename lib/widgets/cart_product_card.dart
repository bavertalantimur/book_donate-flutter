import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartProductCard extends StatelessWidget {
  final Product product;

  const CartProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
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
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle),
              ),
              const Text('1'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle),
              )
            ],
          )
        ],
      ),
    );
  }
}
