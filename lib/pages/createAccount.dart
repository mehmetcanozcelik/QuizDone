// ignore_for_file: file_names, prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/models/kullanici.dart';
import 'package:quizdone/services/authenticationservices.dart';
import 'package:quizdone/services/firestoreService.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String username, email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Create an Account"),
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
                              hintText: "Enter an Username",
                              labelText: "Username :",
                              errorStyle: TextStyle(fontSize: 14.0),
                              prefixIcon: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.green[800],
                              )),
                          validator: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              return "Username field can not be left blank.";
                            } else if (enteredValue.trim().length < 5 ||
                                enteredValue.trim().length > 12) {
                              return "Username must be between 5-12 characters.";
                            }
                            return null;
                          },
                          onSaved: (enteredValue) {
                            username = enteredValue;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autocorrect: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Enter Your Email Address",
                            labelText: "Email :",
                            errorStyle: TextStyle(fontSize: 14.0),
                            prefixIcon: Icon(
                              Icons.mail_outline_outlined,
                              color: Colors.green[800],
                            )),
                        validator: (enteredValue) {
                          if (enteredValue.isEmpty) {
                            return "Please enter your email address.";
                          } else if (!enteredValue.contains("@")) {
                            return "Please enter a valid email address.";
                          }
                          return null;
                        },
                        onSaved: (enteredValue) {
                          email = enteredValue;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Enter Your Password",
                              labelText: "Password :",
                              errorStyle: TextStyle(fontSize: 14.0),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Colors.green[800],
                              )),
                          validator: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              return "Please enter your password.";
                            } else if (enteredValue.trim().length < 4) {
                              return "Password must be 4 or more characters.";
                            }
                            return null;
                          },
                          onSaved: (enteredValue) {
                            password = enteredValue;
                          }),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _createUser,
                          child: Text(
                            "Sign Up",
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

  void _createUser() async {
    final _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    var _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formKey.currentState.save();
      setState(() {
        loading = true;
      });

      try {
        Kullanici kullanici =
            await _authenticationService.signupWithMail(email, password);
        if (kullanici != null) {
          FirestoreService()
              .createUser(id: kullanici.id, email: email, username: username);
        }
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          loading = false;
        });
        String errorCode = error.code;

        showError(errorCode: errorCode);
      }
    }
  }

  showError({errorCode}) {
    String errorMessage;

    if (errorCode == "ERROR_INVALID_EMAIL") {
      errorMessage = "This email is not valid.";
    } else if (errorCode == "ERROR_EMAIL_ALREADY_IN_USE") {
      errorMessage = "This email is already in use.";
    } else if (errorCode == "ERROR_WEAK_PASSWORD") {
      errorMessage = "This password is too weak to use.";
    } else if (errorCode == "ERROR_OPERATION_NOT_ALLOWED") {
      errorMessage = "This operation not allowed.";
    }

    var snackBar = SnackBar(content: Text(errorMessage.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
