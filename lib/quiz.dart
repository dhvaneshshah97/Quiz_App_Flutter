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

  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question 1"),
      ),
      body: Column(
        children: [
          Question(
            questions[_questionIndex]['questionText'],
          ),
          ...(questions[_questionIndex]['answers'] as List<String>)
              .map((answer) {
            return Answer(_answerQuestion, answer);
          }).toList()
        ],
      ),
    );
  }
}
