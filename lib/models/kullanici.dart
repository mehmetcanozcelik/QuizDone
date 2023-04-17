import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Kullanici {
  final String id;
  final String kullaniciAdi;

  Kullanici({required this.id, required this.kullaniciAdi});

  factory Kullanici.firebasedenUret(FirebaseUser kullanici) {
    return Kullanici(
      id: kullanici.uid,
      kullaniciAdi: kullanici.displayName,
    );
  }

  factory Kullanici.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data;
    return Kullanici(
      id: doc.documentID,
      kullaniciAdi: docData['kullaniciAdi'],
    );
  }
}
