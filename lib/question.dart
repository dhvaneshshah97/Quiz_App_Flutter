import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Q. ' + questionText,
        style: TextStyle(fontSize: 23.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
