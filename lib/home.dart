import 'package:CoolQuiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getFname();
    getLname();
    getNname();
    getAge();
  }

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final ageController = TextEditingController();
  int score = 0;

  final _formKey = GlobalKey<FormState>();

  getFname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fname = prefs.getString('fname') ?? '';
    setState(() {
      firstnameController.text = fname;
    });
  }

  getLname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lname = prefs.getString('lname') ?? '';
    setState(() {
      lastnameController.text = lname;
    });
  }

  getNname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nname = prefs.getString('nname') ?? '';
    setState(() {
      nicknameController.text = nname;
    });
  }

  getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String age = prefs.getString('age') ?? '';
    setState(() {
      ageController.text = age;
    });
  }

  addUserDetailstoSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fname', firstnameController.text);
    prefs.setString('lname', lastnameController.text);
    prefs.setString('nname', nicknameController.text);
    prefs.setString('age', ageController.text);
  }

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Value can\'t be empty' : null,
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
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Value can\'t be empty' : null,
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
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Value can\'t be empty' : null,
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
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Value can\'t be empty' : null,
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addUserDetailstoSF();
                            }
                          },
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(
                            "Submit",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                        ),
                        RaisedButton(
                          onPressed: () => _navigateAndDisplayScore(context),
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(
                            "Take Quiz",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10.0),
                        ),
                      ],
                    ),
                  ],
                ),
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
