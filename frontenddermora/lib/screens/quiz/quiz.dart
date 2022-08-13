import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/quiz/answer.dart';
import 'package:frontenddermora/screens/quiz/questions.dart';
import 'package:frontenddermora/util/styles.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Question(
              questions[questionIndex]['questionText'] as String,
            ), //Question
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return Answer(() => answerQuestion(answer['score']),
                  answer['text'] as String);
            }).toList()
          ],
        ),
      ),
    );
  }
}
