import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_application/models/checkout_model.dart';
import 'package:flutter_test_application/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseChekoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
