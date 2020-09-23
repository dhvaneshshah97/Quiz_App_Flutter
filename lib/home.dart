import 'package:CoolQuiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CoolQuiz/scoreStorage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScoreStorage score = ScoreStorage();
  @override
  void initState() {
    super.initState();
    _getFname();
    _getLname();
    _getNname();
    _getAge();
    shouldTakeQuiz();
    score.availability().then((bool val) {
      setState(() {
        _scoreInFile = val;
      });
    });
    score.readScore().then((int value) {
      setState(() {
        _score = value;
      });
    });
  }

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  int _score = 0;
  bool _scoreInFile = false;
  bool _takeQuiz = false;

  shouldTakeQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool present = prefs.containsKey('fname');
    this._takeQuiz = present;
  }

  final _formKey = GlobalKey<FormState>();

  _getFname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fname = prefs.getString('fname') ?? '';
    setState(() {
      _firstnameController.text = fname;
    });
  }

  _getLname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lname = prefs.getString('lname') ?? '';
    setState(() {
      _lastnameController.text = lname;
    });
  }

  _getNname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nname = prefs.getString('nname') ?? '';
    setState(() {
      _nicknameController.text = nname;
    });
  }

  _getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String age = prefs.getString('age') ?? '';
    setState(() {
      _ageController.text = age;
    });
  }

  _addUserDetailstoSF() async {
    this._takeQuiz = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fname', _firstnameController.text);
    prefs.setString('lname', _lastnameController.text);
    prefs.setString('nname', _nicknameController.text);
    prefs.setString('age', _ageController.text);
  }

  _navigateAndDisplayScore(BuildContext context) async {
    int returnedScore = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Quiz(),
        ));
    setState(() {
      if (returnedScore != null) {
        _score = returnedScore;
        score.writeScore(_score);
        this._scoreInFile = true;
      } else {
        _score = 0;
        score.writeScore(_score);
        this._scoreInFile = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.account_box, size: 22),
              ),
              TextSpan(
                  text: " My Profile",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Value can\'t be empty' : null,
                      controller: _firstnameController,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.indigo[400],
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
                      controller: _lastnameController,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.indigo[400],
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
                      controller: _nicknameController,
                      decoration: InputDecoration(
                          labelText: 'Nick Name',
                          labelStyle: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.indigo[400],
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
                      controller: _ageController,
                      decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.indigo[400],
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
                        Builder(
                          builder: (BuildContext context) {
                            return RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _addUserDetailstoSF();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      'Your details are saved',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1),
                                    ),
                                    backgroundColor: Colors.indigo[400],
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 4),
                                  ));
                                }
                              },
                              textColor: Colors.white,
                              color: Colors.indigo[400],
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              padding: EdgeInsets.all(10.0),
                            );
                          },
                        ),
                        Builder(builder: (BuildContext context) {
                          return RaisedButton(
                            onPressed: () {
                              if (this._takeQuiz) {
                                _navigateAndDisplayScore(context);
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    'Please submit your details first!',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                  backgroundColor: Colors.indigo[400],
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            },
                            textColor: Colors.white,
                            color: Colors.indigo[400],
                            child: Text(
                              "Take Quiz",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            padding: EdgeInsets.all(10.0),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              _scoreInFile
                  ? Text(
                      'Your score is: $_score',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
