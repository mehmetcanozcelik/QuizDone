// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/models/kullanici.dart';
import 'package:quizdone/pages/createAccount.dart';
import 'package:quizdone/services/authenticationservices.dart';
import 'package:quizdone/services/firestoreService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                  color: buttonColor,
                )),
            validator: (enteredValue) {
              if (enteredValue.isEmpty) {
                return "Please enter your email address.";
              } else if (!enteredValue.contains("@")) {
                return "Please enter a valid email address.";
              }
              return null;
            },
            onSaved: (enteredValue) => email = enteredValue,
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
                  color: buttonColor,
                )),
            validator: (enteredValue) {
              if (enteredValue.isEmpty) {
                return "Please enter your password.";
              } else if (enteredValue.trim().length < 4) {
                return "Password must be 4 or more characters.";
              }
              return null;
            },
            onSaved: (enteredValue) => password = enteredValue,
          ),
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
                  style: TextButton.styleFrom(backgroundColor: buttonColor),
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
          InkWell(
            onTap: _signinWithGoogle,
            child: Image.asset(
              'assets/googleLogin.png',
              width: 200.0,
              height: 40.0,
            ),
          ),
          SizedBox(height: 20.0),
          Center(child: Text("Forgot my Password")),
        ],
      ),
    );
  }

  void _loginMethod() async {
    final _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        loading = true;
      });

      try {
        await _authenticationService.signinWithMail(email, password);
      } catch (error) {
        setState(() {
          loading = false;
        });
        String errorCode = error.code;

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
      Kullanici kullanici = await _authenticationService.signinWithGoogle();
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
      String errorCode = error.code;

      showError(errorCode: errorCode);
    }
  }

  showError({errorCode}) {
    String errorMessage;

    if (errorCode == "ERROR_USER_NOT_FOUND") {
      errorMessage = "This user is not found.";
    } else if (errorCode == "ERROR_INVALID_EMAIL") {
      errorMessage = "This email is not valid.";
    } else if (errorCode == "ERROR_WRONG_PASSWORD") {
      errorMessage = "Your password is not correct.";
    } else if (errorCode == "ERROR_USER_DISABLED") {
      errorMessage = "This user is banned by admin.";
    } else {
      errorMessage = "Unidentified error has occurred. $errorCode ";
    }

    var snackBar = SnackBar(content: Text(errorMessage.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
