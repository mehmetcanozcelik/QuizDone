// ignore_for_file: prefer_const_constructors
//@dart=2.9
import 'package:flutter/material.dart';
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
              image: AssetImage("assets/deneme.jpg"), fit: BoxFit.cover)),
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
                          title:
                              snapshot.data.documents[index].data["quizTitle"],
                          description:
                              snapshot.data.documents[index].data["quizDesc"]);
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
        title: Center(
          child: Image.asset(
            "assets/QuizDonecolor.png",
            scale: 3.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_task),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SuggestQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;

  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.black54,
                gradient: const LinearGradient(
                    colors: [Colors.black87, Colors.deepPurpleAccent]),
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
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
