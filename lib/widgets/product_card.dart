import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishList;
  const ProductCard({
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishList = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: widthValue,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: widthValue - 10 - leftPosition,
              height: 85,
              decoration: BoxDecoration(
                color: const Color.fromARGB(97, 0, 0, 0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white, fontSize: 24),
                          ),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    isWishList
                        ? Expanded(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
