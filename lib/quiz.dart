import 'package:CoolQuiz/answer.dart';
import 'package:CoolQuiz/question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _questions = const [
    {
      'questionText':
          'Far-right protestors tried to storm the Parliament building in which country?',
      'answers': [
        {'text': 'Australia', 'score': 0},
        {'text': 'Britain', 'score': 0},
        {'text': 'France', 'score': 0},
        {'text': 'Germany', 'score': 1}
      ],
    },
    {
      'questionText':
          'Why did Shinzo Abe, prime minister of Japan, resign from office?',
      'answers': [
        {'text': 'An extramarital affair', 'score': 0},
        {'text': 'Fraud', 'score': 0},
        {'text': 'Illness', 'score': 1},
        {'text': 'Protests', 'score': 0}
      ],
    },
    {
      'questionText':
          'What did two commercial jet pilots reported seeing in the busy airspace near Los Angeles International Airport?',
      'answers': [
        {'text': 'An attack drone', 'score': 0},
        {'text': 'A man with a jetpack', 'score': 1},
        {'text': 'A girl attached to a kite', 'score': 0},
        {'text': 'A U.F.O.', 'score': 0}
      ],
    },
    {
      'questionText':
          'After more than seven decades of absence, jaguars are being reintroduced into the wetlands of which country?',
      'answers': [
        {'text': 'Argentina', 'score': 1},
        {'text': 'Belize', 'score': 0},
        {'text': 'Colombia', 'score': 0},
        {'text': 'Mexico', 'score': 0}
      ],
    },
  ];

  bool pressed = false;

  var _questionIndex = 0;
  var _totalScore = 0;

  void _showNext(int score) {
    _totalScore = _totalScore + score;
    setState(() {
      pressed = true;
    });
  }

  void _answerQuestion() {
    _questionIndex = _questionIndex + 1;
    if (_questionIndex > _questions.length - 1) {
      Navigator.pop(context, _totalScore > 0 ? _totalScore : 0);
      return;
    }
    setState(() {
      pressed = false;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_questionIndex + 1}'),
      ),
      body: _questionIndex < _questions.length
          ? Column(
              children: [
                Question(
                  _questions[_questionIndex]['questionText'],
                ),
                ...(_questions[_questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return Answer(
                      () => _showNext(answer['score']), answer['text']);
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
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        padding: EdgeInsets.all(10.0),
                      )
                    : SizedBox(),
              ],
            )
          : SizedBox(),
    );
  }
}
