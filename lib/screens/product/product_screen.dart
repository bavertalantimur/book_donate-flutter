import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/cart/cart_bloc.dart';
import 'package:flutter_test_application/screens/chat/chat_screen.dart';
import 'package:flutter_test_application/screens/form/book_form_screen.dart';
import 'package:flutter_test_application/screens/mybot/chatbot.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
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
        padding: const EdgeInsets.only(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(
                color: Color(0xFF8E44AD),
                width: 2.0,
              ),
            ),
          ),
          height: 80,
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
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookFormScreen()),
                  );
                },
                icon: Image.asset(
                  'images/contact-form.png',
                  width: 34,
                  height: 34,
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductAdded(product));

                      final snackBar =
                          SnackBar(content: Text('Added to your Cart'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Image.asset(
                      'images/add-to-cart.png',
                      width: 26,
                      height: 26,
                    ),
                    label: Row(
                      children: [
                        SizedBox(width: 8),
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              product.imageUrl, // Use the product's image URL
              fit: BoxFit.contain,
              height: 500,
            ),
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
            child: Column(
              children: [
                AnimatedExpansionTile(
                  title: Row(
                    children: [
                      Image.asset(
                        'images/book.png',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Book Information',
                        style: GoogleFonts.sora(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        product.description,
                        style: GoogleFonts.sora(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  collapsedBackgroundColor: Color(0xFF8E44AD), // Darker purple
                  expandedBackgroundColor:
                      Color.fromARGB(255, 162, 79, 198), // Lighter purple
                  expandedAlignment: Alignment.centerLeft,
                  backgroundColor: Colors.white,
                  childrenPadding: EdgeInsets.all(10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final EdgeInsetsGeometry tilePadding;
  final CrossAxisAlignment expandedCrossAxisAlignment;
  final Alignment expandedAlignment;
  final EdgeInsetsGeometry childrenPadding;
  final Color backgroundColor;
  final Color collapsedBackgroundColor;
  final Color expandedBackgroundColor;

  const AnimatedExpansionTile({
    required this.title,
    required this.children,
    this.tilePadding = EdgeInsets.zero,
    this.expandedCrossAxisAlignment = CrossAxisAlignment.center,
    this.expandedAlignment = Alignment.center,
    this.childrenPadding = EdgeInsets.zero,
    this.backgroundColor = Colors.white,
    this.collapsedBackgroundColor = Colors.transparent,
    this.expandedBackgroundColor = Colors.white,
  });

  @override
  _AnimatedExpansionTileState createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isExpanded
            ? widget.expandedBackgroundColor
            : widget.collapsedBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: _handleTap,
            contentPadding: widget.tilePadding,
            title: widget.title,
            trailing: RotationTransition(
              turns: _iconTurns,
              child: Icon(
                Icons.expand_more,
                color: Colors.white,
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _isExpanded ? 1.0 : 0.0,
              child: Padding(
                padding: widget.childrenPadding,
                child: Column(
                  crossAxisAlignment: widget.expandedCrossAxisAlignment,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
