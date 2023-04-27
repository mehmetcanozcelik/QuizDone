// ignore_for_file: file_names, prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:quizdone/pages/addQuestion.dart';
import 'package:quizdone/services/database.dart';
import 'package:random_string/random_string.dart';

class SuggestQuiz extends StatefulWidget {
  const SuggestQuiz({Key key}) : super(key: key);

  @override
  State<SuggestQuiz> createState() => _SuggestQuizState();
}

class _SuggestQuizState extends State<SuggestQuiz> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String quizSubject, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();

  suggestQuiz() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizSubject": quizSubject,
        "quizDescription": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          loading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestion(quizId),
              ));
        });
      });
    }
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
        body: ListView(
          children: [
            loading
                ? LinearProgressIndicator()
                : SizedBox(
                    height: 0.0,
                  ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                              hintText: "Enter the subject of Quiz.",
                              labelText: "Subject of Quiz : ",
                              errorStyle: TextStyle(fontSize: 14.0),
                              prefixIcon: Icon(
                                Icons.subject_rounded,
                                color: Colors.green[800],
                              )),
                          validator: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              return "Subject field can not be left blank.";
                            } else if (enteredValue.trim().length < 5 ||
                                enteredValue.trim().length > 25) {
                              return "Subject must be between 5-25 characters.";
                            }
                            return null;
                          },
                          onChanged: (enteredValue) {
                            quizSubject = enteredValue;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autocorrect: true,
                        decoration: InputDecoration(
                            hintText: "Enter the description of your Quiz.",
                            labelText: "Description :",
                            errorStyle: TextStyle(fontSize: 14.0),
                            prefixIcon: Icon(
                              Icons.document_scanner,
                              color: Colors.green[800],
                            )),
                        validator: (enteredValue) {
                          if (enteredValue.isEmpty) {
                            return "Description field can not be left blank.";
                          } else if (enteredValue.trim().length < 5 ||
                              enteredValue.trim().length > 100) {
                            return "Description must be between 5-100 characters.";
                          }
                          return null;
                        },
                        onChanged: (enteredValue) {
                          quizDescription = enteredValue;
                        },
                      ),
                      SizedBox(
                        height: 300.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            suggestQuiz();
                          },
                          child: Text(
                            "Create a Quiz",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green[800]),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
