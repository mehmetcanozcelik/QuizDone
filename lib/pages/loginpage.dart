// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/models/kullanici.dart';
import 'package:quizdone/pages/createAccount.dart';
import 'package:quizdone/pages/resetPassword.dart';
import 'package:quizdone/services/authenticationservices.dart';
import 'package:quizdone/services/firestoreService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backgroundddd.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: Stack(
          children: [
            _pageElements(),
            _loadingAnimation(),
          ],
        ),
      ),
    );
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
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 70.0,
              minHeight: 70.0,
            ),
            child: TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Your Email Address",
                  errorStyle: TextStyle(fontSize: 14.0),
                  prefixIcon: Icon(
                    Icons.mail_outline_outlined,
                    color: buttonColor,
                  )),
              validator: (enteredValue) {
                if (enteredValue!.isEmpty) {
                  return "Please enter your email address.";
                } else if (!enteredValue.contains("@")) {
                  return "Please enter a valid email address.";
                }
                return null;
              },
              onSaved: (enteredValue) => email = enteredValue!,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 70.0,
              minHeight: 70.0,
            ),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  errorStyle: TextStyle(fontSize: 14.0),
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: buttonColor,
                  )),
              validator: (enteredValue) {
                if (enteredValue!.isEmpty) {
                  return "Please enter your password.";
                } else if (enteredValue.trim().length < 4) {
                  return "Password must be 4 or more characters.";
                }
                return null;
              },
              onSaved: (enteredValue) => password = enteredValue!,
            ),
          ),
          SizedBox(
            height: 10.0,
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
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
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
                    "Create Account",
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
          Center(
              child: Text(
            "or",
            style: TextStyle(color: Colors.white),
          )),
          SizedBox(height: 10.0),
          InkWell(
            onTap: _signinWithGoogle,
            child: Image.asset(
              'assets/googleLogin.png',
              width: 200.0,
              height: 40.0,
            ),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              child: Text(
                "Forgot your Password?",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ResetPage())),
            )
          ]),
        ],
      ),
    );
  }

  void _loginMethod() async {
    final _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

      try {
        await _authenticationService.signinWithMail(email, password);
      } catch (error) {
        setState(() {
          loading = false;
        });
        String errorCode = error.toString();

        showError(errorCode: errorCode);
      }
    }
  }

  void _signinWithGoogle() async {
    var _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    setState(() {
      loading = true;
    });
    try {
      Kullanici? kullanici = await _authenticationService.signinWithGoogle();
      if (kullanici != null) {
        Kullanici firestoreUser =
            await FirestoreService().checkUser(kullanici.id);
        if (firestoreUser == null) {
          FirestoreService().createUser(
              id: kullanici.id,
              email: kullanici.email,
              username: kullanici.username,
              fotoUrl: kullanici.fotoUrl);
        }
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      String errorCode = error.toString();

      showError(errorCode: errorCode);
    }
  }

  showError({errorCode}) {
    String errorMessage;

    if (errorCode == "ERROR_USER_NOT_FOUND") {
      errorMessage = "This user is not found.";
    } else if (errorCode ==
        "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null, null)") {
      errorMessage = "This email is not valid.";
    } else if (errorCode ==
        "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null, null)") {
      errorMessage = "Your password is not correct.";
    } else if (errorCode == "ERROR_USER_DISABLED") {
      errorMessage = "This user is banned by admin.";
    } else {
      print(errorCode);
      errorMessage = "Unidentified error has occurred. $errorCode ";
    }

    var snackBar = SnackBar(content: Text(errorMessage.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
