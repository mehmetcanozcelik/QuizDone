//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizdone/models/kullanici.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Kullanici _kullaniciOlustur(FirebaseUser kullanici) {
    return kullanici == null ? null : Kullanici.firebasedenUret(kullanici);
  }

  Stream<Kullanici> get durumTakipcisi {
    return _firebaseAuth.onAuthStateChanged.map(_kullaniciOlustur);
  }
}
