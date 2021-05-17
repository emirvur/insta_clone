import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/model/user.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> currentUser() async {
    try {
      FirebaseUser user = await firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(userID: user.uid);
    }
  }

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }

  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    AuthResult sonuc = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: sifre);
    //burada dbye ekleme cunku yeterlı veri elde yok

    return _userFromFirebase(sonuc.user);
  }

  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    AuthResult sonuc = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: sifre);
    return _userFromFirebase(sonuc.user);
  }
}
