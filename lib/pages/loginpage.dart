// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:quizdone/pages/createAccount.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _pageElements(),
        _loadingAnimation(),
      ],
    ));
  }

  Widget _loadingAnimation() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center();
    }
  }

  Widget _pageElements() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
        children: [
          Image.asset(
            'assets/logo.png',
            width: 200.0,
            height: 200.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          TextFormField(
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "Your Email Address",
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
                  hintText: "Password",
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
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _loginMethod,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.green[800]),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateAccount()));
                  },
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[900]),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Center(child: Text("or")),
          SizedBox(height: 10.0),
          Image.asset(
            'assets/googleLogin.png',
            width: 200.0,
            height: 40.0,
          ),
          SizedBox(height: 20.0),
          Center(child: Text("Forgot my Password")),
        ],
      ),
    );
  }

  void _loginMethod() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
    }
    ;
  }
}
