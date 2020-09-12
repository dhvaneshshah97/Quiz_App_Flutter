import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: RaisedButton(
        onPressed: selectHandler,
        child: Text(answerText),
        textColor: Colors.white,
        color: Colors.blue,
      ),
    );
  }
}
