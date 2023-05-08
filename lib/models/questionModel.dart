//@dart=2.9

// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class QuestionModel {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  bool answered;
}

class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({@required this.id, @required this.title, @required this.options});

  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
