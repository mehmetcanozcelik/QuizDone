// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/pages/mainpage.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {Key? key,
      required this.result,
      required this.questionLength,
      required this.onPressed})
      : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: deepPurpleOverlay,
      content: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.transparent,
                  decorationColor: Colors.white70,
                  shadows: [
                    Shadow(color: Colors.white, offset: Offset(0, -10))
                  ],
                  decoration: TextDecoration.underline,
                  decorationThickness: 3),
            ),
            SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              child: Text(
                "$result",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                    color: result / 100 == questionLength / 2
                        ? Colors.black87
                        : Colors.white),
              ),
              radius: 60.0,
              backgroundColor: result > 700 && result < 1000
                  ? Colors.yellow
                  : result < 750
                      ? incorrect
                      : correct,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              result > 700 && result < 1000
                  ? "Keep trying."
                  : result < 750
                      ? "Not that good."
                      : "Great!",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: onPressed,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: yellowOverlay,
                      height: 40.0,
                      width: 160.0,
                      child: Center(
                          child: Text(
                        "Play Again",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      )))),
            ),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainPage())),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: Colors.green,
                      height: 40.0,
                      width: 200.0,
                      child: Center(
                          child: Text(
                        "Go to Main Menu",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      )))),
            ),
          ],
        ),
      ),
    );
  }
}
