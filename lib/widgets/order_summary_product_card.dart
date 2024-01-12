import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/models.dart';

class OrderSummaryProductCard extends StatelessWidget {
  const OrderSummaryProductCard({
    super.key,
    required this.product,
    required this.quantity,
  });
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),
                Text(
                  'Qty. $quantity',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '\$${product.price}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
