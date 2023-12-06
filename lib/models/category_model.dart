import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl];
  static List<Category> categories = [
    Category(
        name: 'YKS',
        imageUrl:
            'https://pegem.net/uploads/p/p/2022-KPSS-Lise-On-Lisans-GY-GK-5-Ders-1-Kitap-Tum-Dersler-Konu-Anlatimi_1.gif'),
    Category(
        name: 'YKS',
        imageUrl:
            'https://palmekitabevi.com/content/images/thumbs/027/0278455_yks-tum-dersler-konu-anlatimli-ozel-tek-kitap_800.gif'),
    Category(
        name: 'ALES',
        imageUrl:
            'https://pegem.net/uploads/p/p/2024-Ales-Soru-Bankasi_1.jpg?v=1683111599')
  ];
}
