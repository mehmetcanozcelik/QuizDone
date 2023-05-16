// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';

class FinishQuizButton extends StatelessWidget {
  const FinishQuizButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: yellowOverlay, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "Finish Quiz",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
