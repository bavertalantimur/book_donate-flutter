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

  Checkout(
      {required this.fullName,
      required this.phone,
      required this.address,
      required this.city,
      required this.district,
      required this.zipCode,
      required this.products,
      required this.subtotal,
      required this.deliveryFee,
      required this.total});

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
      ];

  Map<String, Object> toDocument() {
    Map customerAddress = Map();
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['district'] = district;
    customerAddress['zipCode'] = zipCode;
    return {
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'customerPhone': phone!,
      'products': products!.map((product) => product.name).toList(),
      'subtotal': subtotal!,
      'deliveryFee': deliveryFee!,
      'total': total!
    };
  }
}
