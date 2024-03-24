import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  Future signInAnonymous() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    } catch (e) {
      print("Anon error $e");
      return null;
    }
  }

  Future<String?> forgotPassword(String email) async {
    String? res;
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print("Mail kutunuzu kontrol ediniz");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        res = "Mail Zaten Kayitli.";
      }
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      print("hata" + e.code);
      print(email + password);

      switch (e.code) {
        case "INVALID_LOGIN_CREDENTIALS":
          res = "Kullanici Bulunamadi";
          break;
        case "invalid-email":
          res = "geçersiz email";
          break;

        case "wrong-password":
          res = "Hatali Sifre";
          break;
        case "user-disabled":
          res = "Kullanici Pasif";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    return res;
  }

  Future<String?> signUp(String email, String password, String name,
      String lastName, bool isAdmin) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = result.user!.uid;

      try {
        final resultData =
            await firebaseFirestore.collection("Users").doc(email).set({
          "email": email,
          "name": name,
          "lastname": lastName,
          "password": password,
          "isAdmin": isAdmin,
          "uid": uid,
        });
      } catch (e) {
        print(e.toString());
      }

      res = "success";
    } on FirebaseAuthException catch (e) {
      print(email + password);
      switch (e.code) {
        case "weak-password":
          res = "weak-password";
          break;
        case "email-already-in-use":
          res = "Mail Zaten Kayitli.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          res = "Gecersiz Mail";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    return res;
  }
}
