import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/models.dart';

class BookCard extends StatelessWidget {
  final Product book;

  const BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: book.imageUrl != null
                ? Image.network(
                    book.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Placeholder(), // veya alternatif bir görsel
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.name ?? 'Kitap Adı',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${book.price ?? 'N/A'}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Sepete ekle işlemi
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
