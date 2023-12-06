import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final double price;
  /*final String publicationYear;
  final String publisher;
  final String numberPage;
  final String author;*/
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;

  Product(
      {required this.name,
      required this.category,
      required this.price,
      /*required this.publicationYear,
      required this.publisher,
      required this.numberPage,
      required this.author,*/
      required this.imageUrl,
      required this.isRecommended,
      required this.isPopular});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        category,
        price,
        /*publicationYear,
        publisher,
        numberPage,
        author,*/
        imageUrl,
        isRecommended,
        isPopular,
      ];

  static List<Product> products = [
    Product(
        name: 'acil mat',
        category: 'YKS',
        price: 300,
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599',
        isRecommended: true,
        isPopular: false),
    Product(
        name: 'acil mat',
        category: 'YKS',
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599',
        price: 600,
        isRecommended: true,
        isPopular: false),
    Product(
        name: 'acil mat',
        category: 'ALES',
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599',
        price: 400,
        isRecommended: true,
        isPopular: false)
  ];
}
