// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class FinishQuizButton extends StatelessWidget {
  const FinishQuizButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.deepPurple[700],
          borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "Finish Quiz",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
