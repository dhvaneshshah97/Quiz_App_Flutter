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
  @override
  void initState() {
    _populateScoreArray();
    _populateAnswerArray();
    super.initState();
  }

  List _questions = [];
  bool pressed = false;
  int _questionIndex = 0;
  int _totalScore = 0;
  List _currScore;
  List _currAns;
  String _character;

  // load json asset
  Future<String> _loadAQuestionAsset() async {
    return await rootBundle.loadString('assets/questions.json');
  }

  Future<void> _populateScoreArray() async {
    String jsonString = await _loadAQuestionAsset();
    final jsonResponse = jsonDecode(jsonString);
    setState(() {
      _currScore = List.filled(jsonResponse['questions'].length, 0);
    });
  }

  Future<void> _populateAnswerArray() async {
    String jsonString = await _loadAQuestionAsset();
    final jsonResponse = jsonDecode(jsonString);
    setState(() {
      _currAns = List.filled(jsonResponse['questions'].length, '');
    });
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
    _totalScore = _totalScore + _currScore[_questionIndex];
    if (_questionIndex >= _questions.length - 1) {
      Navigator.pop(context, _totalScore > 0 ? _totalScore : 0);
      return;
    }
    _questionIndex = _questionIndex + 1;
    setState(() {
      pressed = false;
      _character = _currAns[_questionIndex];
      if (_character != '') {
        pressed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (this._questionIndex == 0) {
          return true;
        } else {
          _questionIndex = _questionIndex - 1;
          pressed = true;
          _character = _currAns[_questionIndex];
          if (_totalScore != 0 && _currScore[_questionIndex] == 1) {
            _totalScore = _totalScore - 1;
          }
          return false;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Question ${_questionIndex + 1}'),
            backgroundColor: Colors.indigo[400],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
              child: Column(
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
                                          _currScore[_questionIndex] =
                                              answer['score'];
                                          _currAns[_questionIndex] =
                                              answer['text'];
                                          // print(_currScore[_questionIndex]);
                                          // print(answer['score']);
                                          // print(_currScore);
                                          // print(_character);
                                        });
                                      },
                                    ));
                              }).toList(),
                              pressed
                                  ? RaisedButton(
                                      onPressed: _answerQuestion,
                                      textColor: Colors.white,
                                      color: Colors.indigo[400],
                                      shape: StadiumBorder(),
                                      child: Text(
                                        _questionIndex == _questions.length - 1
                                            ? "End & Submit"
                                            : "Next",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
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
              ),
            ),
          )),
    );
  }
}
