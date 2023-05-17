// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '$question',
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
