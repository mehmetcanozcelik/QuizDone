import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Kullanici {
  final String id;
  final String username;
  final String email;
  final String fotoUrl;
  final String about;

  Kullanici(
      {required this.id,
      required this.username,
      required this.email,
      required this.about,
      required this.fotoUrl});

  factory Kullanici.firebasedenUret(FirebaseUser kullanici) {
    return Kullanici(
        id: kullanici.uid,
        username: kullanici.displayName,
        email: kullanici.email,
        fotoUrl: kullanici.photoUrl,
        about: "");
  }

  factory Kullanici.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data;
    return Kullanici(
      id: doc.documentID,
      username: docData['username'],
      email: docData['email'],
      fotoUrl: doc['fotoUrl'],
      about: doc['about'],
    );
  }
}
