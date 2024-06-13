import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/cart/cart_bloc.dart';
// import 'package:flutter_test_application/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_test_application/screens/mybot/chatbot.dart';
import 'package:flutter_test_application/screens/screens.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
import 'package:flutter_test_application/widgets/hero_carousel_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/product_model.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProductScreen(product: product),
    );
  }

  final Product product;

  const ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.category),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: BottomAppBar(
              color: Color(0xFFF5F5F5),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        'images/chat.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatBot()),
                        );
                      },
                      icon: Image.asset(
                        'images/robot.png',
                        width: 38,
                        height: 38,
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(CartProductAdded(product));

                            final snackBar =
                                SnackBar(content: Text('Added to your Cart'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushNamed(context, '/cart');
                          },
                          icon: Image.asset(
                            'images/add-to-cart.png',
                            width: 28,
                            height: 28,
                          ),
                          label: Row(
                            children: [
                              SizedBox(width: 4),
                              Text(
                                'Add to cart',
                                style: GoogleFonts.sora(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF242424),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              HeroCarouselCard(
                product: product,
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.sora(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: GoogleFonts.sora(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Product Information',
                style: GoogleFonts.sora(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF242424),
                  ),
                ),
              ),
              children: [
                ListTile(
                  title: Text(
                    product.description,
                    style: GoogleFonts.sora(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF242424),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
