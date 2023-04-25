// ignore_for_file: import_of_legacy_library_into_null_safe, unused_field, file_names
//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdone/models/kullanici.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;
  final DateTime time = DateTime.now();

  Future<void> createUser({id, email, username, fotoUrl = ""}) async {
    await _firestore.collection("users").document(id).setData({
      "username": username,
      "email": email,
      "fotoUrl": fotoUrl,
      "about": "",
      "creationtime": time
    });
  }

  Future<Kullanici> checkUser(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").document(id).get();

    if (doc.exists) {
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
    return null;
  }
}
