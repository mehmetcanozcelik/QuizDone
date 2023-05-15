// ignore_for_file: file_names, prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/services/database.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String question, option1, option2, option3, option4;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          loading = false;
          _formKey.currentState.reset();
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
            height: 10.0,
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
                            hintText: "Enter your question.",
                            labelText: "Question : ",
                            errorStyle: TextStyle(fontSize: 14.0),
                            prefixIcon: Icon(Icons.question_answer_rounded,
                                color: Colors.grey[800])),
                        validator: (enteredValue) {
                          if (enteredValue.isEmpty) {
                            return "Question field can not be left blank.";
                          } else if (enteredValue.trim().length < 5 ||
                              enteredValue.trim().length > 140) {
                            return "Questions must be between 5-140 characters.";
                          }
                          return null;
                        },
                        onChanged: (enteredValue) {
                          question = enteredValue;
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Enter the first (CORRECT) option.",
                          labelText: "Option 1 (Correct Option) :",
                          errorStyle: TextStyle(fontSize: 14.0),
                          prefixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green[800],
                          )),
                      validator: (enteredValue) {
                        if (enteredValue.isEmpty) {
                          return "Option field can not be left blank.";
                        } else if (enteredValue.trim().length > 140) {
                          return "Options cannot be longer than 140 characters.";
                        }
                        return null;
                      },
                      onChanged: (enteredValue) {
                        option1 = enteredValue;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Enter the second option",
                          labelText: "Option 2 :",
                          errorStyle: TextStyle(fontSize: 14.0),
                          prefixIcon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red[800],
                          )),
                      validator: (enteredValue) {
                        if (enteredValue.isEmpty) {
                          return "Option field can not be left blank.";
                        } else if (enteredValue.trim().length > 140) {
                          return "Options cannot be longer than 140 characters.";
                        }
                        return null;
                      },
                      onChanged: (enteredValue) {
                        option2 = enteredValue;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Enter the third option.",
                          labelText: "Option 3 :",
                          errorStyle: TextStyle(fontSize: 14.0),
                          prefixIcon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red[800],
                          )),
                      validator: (enteredValue) {
                        if (enteredValue.isEmpty) {
                          return "Option field can not be left blank.";
                        } else if (enteredValue.trim().length > 140) {
                          return "Options cannot be longer than 140 characters.";
                        }
                        return null;
                      },
                      onChanged: (enteredValue) {
                        option3 = enteredValue;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Enter the fourth option.",
                          labelText: "Option 4 :",
                          errorStyle: TextStyle(fontSize: 14.0),
                          prefixIcon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red[800],
                          )),
                      validator: (enteredValue) {
                        if (enteredValue.isEmpty) {
                          return "Option field can not be left blank.";
                        } else if (enteredValue.trim().length > 140) {
                          return "Options cannot be longer than 140 characters.";
                        }
                        return null;
                      },
                      onChanged: (enteredValue) {
                        option4 = enteredValue;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          uploadQuestionData();
                        },
                        child: Text(
                          "Add Question",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.orange[800]),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Suggest Quiz",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: buttonColor),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
