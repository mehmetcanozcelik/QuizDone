// ignore_for_file: camel_case_types, file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_conditional_assignment, unused_field, prefer_final_fields
//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/models/questionModel.dart';
import 'package:quizdone/services/database.dart';
import 'package:quizdone/widgets/next_button.dart';
import 'package:quizdone/widgets/option_card.dart';
import 'package:quizdone/widgets/questionWidget.dart';

class playQuiz extends StatefulWidget {
  playQuiz({Key key}) : super(key: key);

  @override
  State<playQuiz> createState() => _playQuizState();
}

class _playQuizState extends State<playQuiz> {
  List<Question> _questions = [
    Question(id: '10', title: 'What is the capital of Turkey?', options: {
      'Istanbul': false,
      'Izmir': false,
      'Ankara': true,
      'Adana': false
    }),
    Question(id: '11', title: 'Who is the president of the USA?', options: {
      'Kamala Harris': false,
      'Joe Biden': true,
      'Barrack Obama': false,
      'Donald Trump': false
    })
  ];

  int index = 0;
  bool isClicked = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isClicked) {
        setState(() {
          index++;
          isClicked = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select any option."),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20.0),
        ));
      }
    }
  }

  void changeColor() {
    setState(() {
      isClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/QuizDonecolor.png",
          scale: 3.0,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgrounddd.jpg"),
                fit: BoxFit.cover)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
                question: _questions[index].title,
                indexAction: index,
                totalQuestions: _questions.length),
            Divider(
              color: Colors.black87,
            ),
            SizedBox(
              height: 25.0,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              OptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: isClicked
                    ? _questions[index].options.values.toList()[i] == true
                        ? correct
                        : incorrect
                    : buttonColor,
                onTap: changeColor,
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
