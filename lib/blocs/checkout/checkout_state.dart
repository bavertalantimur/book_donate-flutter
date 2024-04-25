part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
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
  final Checkout checkout;
  final PaymentMethod paymentMethod;

  CheckoutLoaded({
    this.fullName,
    this.phone,
    this.address,
    this.city,
    this.district,
    this.zipCode,
    this.products,
    this.subtotal,
    this.deliveryFee,
    this.total,
    this.paymentMethod = PaymentMethod.google_pay,
  }) : checkout = Checkout(
            fullName: fullName,
            phone: phone,
            address: address,
            city: city,
            district: district,
            zipCode: zipCode,
            products: products,
            subtotal: subtotal,
            deliveryFee: deliveryFee,
            total: total);
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
        paymentMethod,
      ];
}
