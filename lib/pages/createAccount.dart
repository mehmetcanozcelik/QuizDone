// ignore_for_file: file_names, prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(
                children: [
                  TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
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
                  ),
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
                      }),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
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
}
