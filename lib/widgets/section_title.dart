import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: GoogleFonts.sora(
            textStyle: TextStyle(
              fontSize: 25, // 20px olarak ayarlandı
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424), // Kalın font olarak ayarlandı
            ),
          ),
        ),
      ),
    );
  }
}
