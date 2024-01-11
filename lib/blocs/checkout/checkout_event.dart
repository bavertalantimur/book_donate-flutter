part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? fullName;
  final String? phone;
  final String? address;
  final String? city;
  final String? district;
  final String? zipCode;
  final Cart? cart;

  UpdateCheckout({
    this.fullName,
    this.phone,
    this.address,
    this.city,
    this.district,
    this.zipCode,
    this.cart,
  });

  @override
  List<Object?> get props => [
        fullName,
        phone,
        address,
        city,
        district,
        zipCode,
        cart,
      ];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;

  const ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
