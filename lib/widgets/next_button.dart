// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
          color: yellowOverlay, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "Next Question",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}
