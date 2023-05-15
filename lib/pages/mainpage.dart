// ignore_for_file: prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizdone/constants.dart';
import 'package:quizdone/pages/playQuiz.dart';
import 'package:quizdone/pages/suggestQuiz.dart';
import 'package:quizdone/services/authenticationservices.dart';
import 'package:quizdone/services/database.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  Widget quizList() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backgrounddd.jpg"), fit: BoxFit.cover)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                        imgUrl:
                            snapshot.data.documents[index].data["quizImgUrl"],
                        title: snapshot.data.documents[index].data["quizTitle"],
                        description:
                            snapshot.data.documents[index].data["quizDesc"],
                        quizId: snapshot.data.documents[index].data["quizId"],
                      );
                    });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
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
        iconTheme: IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
              onPressed: _signOutApp, icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_task),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SuggestQuiz()));
        },
      ),
    );
  }

  void _signOutApp() {
    Provider.of<AuthenticationService>(context, listen: false).signOut();
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String quizId;

  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => playQuiz(quizId),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 150.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 4.0),
                  borderRadius: BorderRadius.circular(8.0),
                  color: blackOverlay,
                  gradient: const LinearGradient(
                      colors: [Colors.black87, deepPurpleOverlay]),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
