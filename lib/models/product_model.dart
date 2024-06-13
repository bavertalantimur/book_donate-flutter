import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String description;
  final bool isRecommended;
  final bool isPopular;

  const Product(
      {required this.name,
      required this.category,
      required this.price,
      required this.description,
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
        description,
        price,
        /*publicationYear,
        publisher,
        numberPage,
        author,*/
        imageUrl,
        isRecommended,
        isPopular,
      ];
  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        name: snap['name'],
        category: snap['category'],
        price: snap['price'],
        description: snap['description'],
        imageUrl: snap['imageUrl'],
        isRecommended: snap['isRecommended'],
        isPopular: snap['isPopular']);
    return product;
  }

  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('products')
              .where('category', isEqualTo: category)
              .get();

      return querySnapshot.docs
          .map((doc) => Product.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  /*static List<Product> products = [
    Product(
        name: 'acil mat',
        category: 'YKS',
        price: 30.4,
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599',
        isRecommended: true,
        isPopular: true),
    Product(
        name: 'acil mat',
        category: 'YKS',
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599',
        price: 20.4,
        isRecommended: true,
        isPopular: false),
    Product(
        name: 'Soru',
        category: 'ALES',
        imageUrl:
            'https://productimages.hepsiburada.net/s/43/375-375/10769323524146.jpg',
        price: 20.5,
        isRecommended: true,
        isPopular: false)
  ];*/
}
