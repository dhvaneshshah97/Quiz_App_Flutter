import 'package:CoolQuiz/answer.dart';
import 'package:CoolQuiz/question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final questions = const [
    {
      'questionText':
          'Far-right protestors tried to storm the Parliament building in which country?',
      'answers': ['Australia', 'Britain', 'France', 'Germany'],
    },
    {
      'questionText':
          'Why did Shinzo Abe, prime minister of Japan, resign from office?',
      'answers': ['An extramarital affair', 'Fraud', 'Illness', 'Protests'],
    },
    {
      'questionText':
          'What did two commercial jet pilots reported seeing in the busy airspace near Los Angeles International Airport?',
      'answers': [
        'An attack drone',
        'A man with a jetpack',
        'A girl attached to a kite',
        'A U.F.O.'
      ],
    },
    {
      'questionText':
          'After more than seven decades of absence, jaguars are being reintroduced into the wetlands of which country?',
      'answers': ['Argentina', 'Belize', 'Colombia', 'Mexico'],
    },
  ];

  bool pressed = false;

  var _questionIndex = 0;

  void _showNext() {
    setState(() {
      pressed = true;
    });
  }

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
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
      body: _questionIndex < questions.length
          ? Column(
              children: [
                Question(
                  questions[_questionIndex]['questionText'],
                ),
                ...(questions[_questionIndex]['answers'] as List<String>)
                    .map((answer) {
                  return Answer(_showNext, answer);
                }).toList(),
                pressed
                    ? RaisedButton(
                        onPressed: _answerQuestion,
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          _questionIndex == questions.length - 1
                              ? "End"
                              : "Next",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        padding: EdgeInsets.all(10.0),
                      )
                    : SizedBox(),
              ],
            )
          : Center(
              child: Text('You did it'),
            ),
    );
  }
}
