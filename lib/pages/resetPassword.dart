// ignore_for_file: file_names, prefer_const_constructors
//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/models/kullanici.dart';
import 'package:quizdone/services/authenticationservices.dart';
import 'package:quizdone/services/firestoreService.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Reset My Password"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/backgroundddd.jpg"),
                  fit: BoxFit.cover)),
          child: ListView(
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Enter Your Email Address",
                              labelText: "Email :",
                              errorStyle: TextStyle(fontSize: 14.0),
                              prefixIcon: Icon(
                                Icons.mail_outline_outlined,
                                color: buttonColor,
                              )),
                          onChanged: (enteredValue) {
                            email = enteredValue;
                          },
                          validator: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              return "Please enter your email address.";
                            } else if (!enteredValue.contains("@")) {
                              return "Please enter a valid email address.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (email != null) {
                                auth.sendPasswordResetEmail(email: email);
                                showSnackBar();
                                Navigator.of(context).pop();
                              } else {
                                showError();
                              }
                            },
                            child: Text(
                              "Send a Reset Password Request",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: buttonColor),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  showSnackBar() {
    String errorMessage;

    errorMessage = "Your password reset email has been sent.";

    var snackBar = SnackBar(content: Text(errorMessage.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showError() {
    String errorMessage;

    errorMessage = "Please enter a valid email.";

    var snackBar = SnackBar(content: Text(errorMessage.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
