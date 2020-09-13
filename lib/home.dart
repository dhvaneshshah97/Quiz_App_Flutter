import 'package:CoolQuiz/quiz.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final ageController = TextEditingController();

  int score = 0;

  _navigateAndDisplayScore(BuildContext context) async {
    int returnedScore = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Quiz(),
        ));
    setState(() {
      if (returnedScore != null) {
        score = returnedScore;
      } else {
        score = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          child: Column(
            children: [
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.orange,
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.orange,
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(
                    labelText: 'Nick Name',
                    labelStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.orange,
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.orange,
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  RaisedButton(
                    onPressed: () => _navigateAndDisplayScore(context),
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Take Quiz",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
              Text(
                'Your score is: $score',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
