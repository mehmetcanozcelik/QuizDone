// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizdone/services/authenticationservices.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () => AuthenticationService().signOut(),
              child: Text("Sign Out"))),
    );
  }
}
