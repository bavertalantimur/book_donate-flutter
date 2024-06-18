import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.sora(
          textStyle: TextStyle(
              color: Color(0xFF242424),
              fontSize: 24,
              fontWeight: FontWeight.bold // Başlık için font boyutu
              ),
        ),
      ),
      /*
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/wishlist');
          },
          icon: Icon(Icons.favorite),
        )
      ],*/
    );
  }
}
