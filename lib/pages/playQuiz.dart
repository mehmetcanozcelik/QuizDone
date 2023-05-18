// ignore_for_file: camel_case_types, file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_conditional_assignment, unused_field, prefer_final_fields, missing_return, prefer_const_literals_to_create_immutables
//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/models/questionModel.dart';
import 'package:quizdone/pages/results.dart';
import 'package:quizdone/services/database.dart';
import 'package:quizdone/widgets/finishQuiz_button.dart';
import 'package:quizdone/widgets/next_button.dart';
import 'package:quizdone/widgets/option_card.dart';
import 'package:quizdone/widgets/questionWidget.dart';
import 'package:quizdone/pages/mainpage.dart';

class playQuiz extends StatefulWidget {
  final String quizId;
  playQuiz(this.quizId);
  @override
  State<playQuiz> createState() => _playQuizState(quizId);
}

class _playQuizState extends State<playQuiz> {
  final String quizId;
  _playQuizState(this.quizId);
  var db = DatabaseService();

  Future extractedData;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    extractedData = getData();
    super.initState();
  }

  // List<Question> extractedData = [
  //   Question(id: '10', title: 'What is the capital of Turkey?', options: {
  //     'Istanbul': false,
  //     'Izmir': false,
  //     'Ankara': true,
  //     'Adana': false
  //   }),
  //   Question(id: '11', title: 'Who is the president of the USA?', options: {
  //     'Kamala Harris': false,
  //     'Joe Biden': true,
  //     'Barrack Obama': false,
  //     'Donald Trump': false
  //   })
  // ];

  int index = 0;
  bool isClicked = false;
  int score = 0;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: playAgain,
              ));
    } else {
      if (isClicked) {
        setState(() {
          index++;
          isClicked = false;
          isAlreadySelected = false;
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

  void finishQuiz(int questionLength) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
              result: score,
              questionLength: questionLength,
              onPressed: playAgain,
            ));
  }

  void checkAnswer(bool value) {
    if (isAlreadySelected == true) {
      return;
    } else {
      if (value == true) {
        score = score + 100;
        setState(() {
          isClicked = true;
          isAlreadySelected = true;
        });
      } else {
        setState(() {
          isClicked = true;
          isAlreadySelected = true;
        });
      }
    }
  }

  void playAgain() {
    setState(() {
      index = 0;
      score = 0;
      isClicked = false;
      isAlreadySelected = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: extractedData as Future<List<Question>>,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data as List<Question>;
              int questionIndex = extractedData.length;

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset(
                    "assets/QuizDonecolor.png",
                    scale: 6,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black87),
                  actions: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 18.0, 5.0, 18.0),
                      child: Text(
                        "Score: $score",
                        style: TextStyle(fontSize: 18.0, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                body: _buildQuizBody(extractedData),
                floatingActionButton: (index < extractedData.length &&
                        extractedData[index].subject == quizId)
                    ? GestureDetector(
                        onTap: () => nextQuestion(questionIndex),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NextButton(),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => finishQuiz(questionIndex),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FinishQuizButton(),
                        ),
                      ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }
          } else {
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/backgroundddd.jpg"),
                        fit: BoxFit.cover)),
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _buildQuizBody(List<Question> extractedData) {
    while (index < extractedData.length &&
        extractedData[index].subject != quizId) {
      index++;
    }

    if (index < extractedData.length) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundddd.jpg"),
                fit: BoxFit.cover)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            QuestionWidget(
                question: extractedData[index].title,
                indexAction: index,
                totalQuestions: extractedData.length),
            Divider(
              color: Colors.black87,
            ),
            SizedBox(
              height: 15.0,
            ),
            for (int i = 0; i < extractedData[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswer(
                    extractedData[index].options.values.toList()[i]),
                child: OptionCard(
                  option: extractedData[index].options.keys.toList()[i],
                  color: isClicked
                      ? extractedData[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : deepestPurple,
                ),
              ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/finish.jpg"), fit: BoxFit.cover),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
      );
    }
  }
}
