import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/quiz/quiz.dart';
import 'package:frontenddermora/screens/quiz/result.dart';
import 'package:frontenddermora/services/api_service.dart';
import 'package:frontenddermora/util/styles.dart';
import 'dart:math';

class MainQuiz extends StatefulWidget {
  const MainQuiz({Key? key}) : super(key: key);

  @override
  State<MainQuiz> createState() => _MainQuizState();
}

class _MainQuizState extends State<MainQuiz> {
  num dry = 0;
  num oily = 0;
  num comb = 0;
  num normal = 0;

  final _questions = [
    {
      'questionText': 'Which most closely describes the look of your pores?',
      'answers': [
        {'text': 'Large and visible all over', 'score': 2},
        {'text': 'Medium sized all over', 'score': 1},
        {'text': 'Small, not easily noticed all over.', 'score': 4},
        {
          'text': 'Large or medium sized and only visible in T zone',
          'score': 3
        },
      ],
    },
    {
      'questionText': 'Texture of your skin?',
      'answers': [
        {'text': 'Skin needs a moisture.', 'score': 1},
        {'text': 'My face is oily and shiny all over.', 'score': 2},
        {
          'text': 'My eyes are puffy and my skin feels somewhat dry.',
          'score': 4
        },
        {
          'text': 'My forehead is very oily but my cheeks feel dry.',
          'score': 3
        },
        {
          'text': 'My skin is calm with a light layer of oil all over.',
          'score': 3
        },
        {'text': 'My skin is oily and broken out.', 'score': 2},
      ],
    },
    {
      'questionText': 'What Do You Feel When You Touch Your Skin?',
      'answers': [
        {'text': 'Oily in some places dry in others', 'score': 3},
        {'text': 'Rough and scaly', 'score': 1},
        {'text': 'Healthy and smooth', 'score': 4},
        {'text': 'Slick and greasy', 'score': 2},
      ],
    },
    {
      'questionText': 'How Does Your Skin Feel After You Wash Your Face?',
      'answers': [
        {'text': 'Clean until the oil soon returns', 'score': 2},
        {'text': 'Itchy and a bit dry', 'score': 1},
        {'text': 'Clean, healthy, and even', 'score': 4},
        {'text': 'Clean in the T zone but dry on the cheeks', 'score': 3},
      ],
    },
    {
      'questionText': 'How often do you have pimples?',
      'answers': [
        {
          'text': 'Very seldom',
          'score': 1,
        },
        {'text': 'Never', 'score': 4},
        {'text': 'Sometimes.', 'score': 3},
        {'text': 'Very often', 'score': 2},
      ],
    },
    {
      'questionText': 'Do you have visible sun damage?',
      'answers': [
        {
          'text': 'Yes – I have discoloration and sun spots all over my face.',
          'score': 2,
        },
        {
          'text': 'Yes – I have some sun spots around my nose and cheeks.',
          'score': 3
        },
        {'text': 'No – I have no sun damage.', 'score': 4},
      ],
    },
  ];
  var _questionIndex = 0;
  num _totalScore = 0;
  String resultText = "";

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(num score) async {
    if (score == 1) dry++;
    if (score == 2) oily++;
    if (score == 3) comb++;
    if (score == 4) normal++;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      var res = [dry, oily, comb, normal].reduce((max));
      setState(() {
        _totalScore = (res * 100 / 7);
      });
      var txt = "";
      if (res == dry) {
        txt = "Dry";
      } else if (res == comb) {
        txt = "Combination";
      } else if (res == normal) {
        txt = "Normal";
      } else if (res == oily) {
        txt = "Oily";
      }
      setState(() {
        resultText = txt;
      });

      await APIService.updateSkinType(resultText);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kSecBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, 0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, resultText, _resetQuiz),
        ),
      ), //Padding      )
    );
  }
}
