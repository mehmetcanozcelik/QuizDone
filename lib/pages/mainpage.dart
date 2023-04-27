// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizdone/pages/suggestQuiz.dart';
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
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/QuizDonecolor.png",
            scale: 3.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_task),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SuggestQuiz()));
        },
      ),
    );
  }
}
