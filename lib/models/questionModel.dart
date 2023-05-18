// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class QuestionModel {
  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String correctOption;
  late bool answered;
}

class Question {
  final String id;
  final String title;
  final Map<String, bool> options;
  final String subject;

  Question(
      {required this.id,
      required this.title,
      required this.options,
      required this.subject});

  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
