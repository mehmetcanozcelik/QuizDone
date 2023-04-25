import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/directed.dart';
import 'package:quizdone/services/authenticationservices.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationService>(
      create: (_) => AuthenticationService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projem',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Director(),
      ),
    );
  }
}
