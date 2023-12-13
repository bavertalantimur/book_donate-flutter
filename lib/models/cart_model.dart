import 'package:equatable/equatable.dart';
import 'package:flutter_test_application/models/models.dart';

class Cart extends Equatable {
  Cart();

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFee(subtotal) {
    if (subtotal >= 1400) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String freeDelivery(subtotal) {
    if (subtotal >= 1400.0) {
      return 'You Have Free Delivery';
    } else {
      double missing = 1400.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);

  @override
  List<Object?> get props => [];

  List<Product> products = [
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
