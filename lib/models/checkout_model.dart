import 'package:equatable/equatable.dart';
import 'package:flutter_test_application/models/models.dart';

class Checkout extends Equatable {
  final String? fullName;
  final String? phone;
  final String? address;
  final String? city;
  final String? district;
  final String? zipCode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final bool isAccepted;
  final bool isCancelled;
  final bool isDelivered;
  final DateTime createdAt;

  Checkout({
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.district,
    required this.zipCode,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    this.isAccepted = false,
    this.isCancelled = false,
    this.isDelivered = false,
    DateTime? createdAt, // Nullable to allow auto-assignment
  }) : createdAt =
            createdAt ?? DateTime.now(); // Default to now if not provided

  @override
  List<Object?> get props => [
        fullName,
        phone,
        address,
        city,
        district,
        zipCode,
        products,
        subtotal,
        deliveryFee,
        total,
        isAccepted,
        isCancelled,
        isDelivered,
        createdAt,
      ];

  Map<String, Object> toDocument() {
    Map<String, String?> customerAddress = {
      'address': address,
      'city': city,
      'district': district,
      'zipCode': zipCode,
    };
    return {
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'customerPhone': phone!,
      'products': products!.map((product) => product.name).toList(),
      'subtotal': subtotal!,
      'deliveryFee': deliveryFee!,
      'total': total!,
      'isAccepted': isAccepted,
      'isCancelled': isCancelled,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
      
    };
  }
}
