import 'package:CoolQuiz/question.dart';
import 'package:flutter/material.dart';
// import 'package:CoolQuiz/questions_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _questions = [];
  bool pressed = false;
  var _questionIndex = 0;
  var _totalScore = 0;
  var _currScore = 0;
  String _character;

  // load json asset
  Future<String> _loadAQuestionAsset() async {
    return await rootBundle.loadString('assets/questions.json');
  }

  Future<List> _parseJson() async {
    String jsonString = await _loadAQuestionAsset();
    final jsonResponse = jsonDecode(jsonString);
    setState(() {
      _questions = jsonResponse['questions'];
    });
    return jsonResponse['questions'];
  }

  void _answerQuestion() {
    if (_questionIndex >= _questions.length - 1) {
      print('hello');
      Navigator.pop(context, _totalScore > 0 ? _totalScore : 0);
      return;
    }
    _totalScore = _totalScore + _currScore;
    _questionIndex = _questionIndex + 1;
    setState(() {
      pressed = false;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (this._questionIndex == 0) {
          return true;
        } else {
          _questionIndex = _questionIndex - 1;
          return false;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Question ${_questionIndex + 1}'),
          ),
          body: Column(
            children: [
              FutureBuilder<List>(
                  future: _parseJson(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Question(
                            _questions[_questionIndex]['questionText'],
                          ),
                          ...(_questions[_questionIndex]['answers'])
                              .map((answer) {
                            return ListTile(
                                title: Text(answer['text']),
                                leading: Radio(
                                  value: answer['text'],
                                  groupValue: _character,
                                  onChanged: (dynamic text) {
                                    setState(() {
                                      text = answer['text'];
                                      _character = text;
                                      pressed = true;
                                      _currScore = answer['score'];
                                    });
                                  },
                                ));
                          }).toList(),
                          pressed
                              ? RaisedButton(
                                  onPressed: _answerQuestion,
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  child: Text(
                                    _questionIndex == _questions.length - 1
                                        ? "End"
                                        : "Next",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                )
                              : SizedBox(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          )),
    );
  }
}
