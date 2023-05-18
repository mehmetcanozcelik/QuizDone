import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/models/kullanici.dart';
import 'package:quizdone/pages/loginpage.dart';
import 'package:quizdone/pages/mainpage.dart';
import 'package:quizdone/services/authenticationservices.dart';

class Director extends StatelessWidget {
  const Director({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    return StreamBuilder(
        stream: _authenticationService.durumTakipcisi,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            Object? aktifKullanici = snapshot.data;
            return MainPage();
          } else {
            return LoginPage();
          }
        });
  }
}
