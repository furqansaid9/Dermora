// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/auth/login.dart';
import 'package:frontenddermora/screens/auth/register.dart';
import 'package:frontenddermora/screens/welcome/components/intro_widget.dart';
import 'package:frontenddermora/util/styles.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double screenWidth = 0.0;
  double screenheight = 0.0;
  int currentPageValue = 0;
  int previousPageValue = 0;

  late PageController controller;
  double _moveBar = 0.0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPageValue);
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');

    if (previousPageValue == 0) {
      previousPageValue = page;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < page) {
        previousPageValue = page;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = page;
        _moveBar = _moveBar - 0.14;
      }
    }
    print(currentPageValue);
    print(previousPageValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    final List<Widget> introWidgetsList = <Widget>[
      IntroWidget(
        screenWidth: screenWidth,
        screenheight: screenheight,
        image: 'assets/images/illustration-1.png',
        secImage: 'assets/images/logoo.png',
        type: 'Welcome To Dermora',
        startGradientColor: kBlue,
        endGradientColor: kPruple,
        subText: 'Your personal assistant for all of your skin care needs',
        fontSize: 26.0,
      ),
      IntroWidget(
        screenWidth: screenWidth,
        screenheight: screenheight,
        image: 'assets/images/illustration-2.png',
        secImage: "false",
        type: 'Monitor and follow your routine steps',
        startGradientColor: kBlue,
        endGradientColor: kPruple,
        subText: 'Never miss any step in your daily routine',
        fontSize: 26.0,
      ),
      IntroWidget(
        screenWidth: screenWidth,
        screenheight: screenheight,
        image: 'assets/images/illustration-3.png',
        secImage: "false",
        type: 'Chat with dermatologist',
        startGradientColor: kBlue,
        endGradientColor: kPruple,
        subText: 'Ask skincare questions and get answers in real time',
        fontSize: 26.0,
      ),
    ];

    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return introWidgetsList[index];
            },
            controller: controller,
            itemCount: introWidgetsList.length,
            onPageChanged: (int page) {
              getChangedPageAndMoveBar(page);
            },
          ),
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    for (var i in introWidgetsList) slidingBar(),
                    FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        if (controller.page == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        }
                        onAddButtonTappedNext();
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastOutSlowIn,
                margin:
                    EdgeInsets.only(bottom: 35, left: screenWidth * _moveBar),
                child: movingBar(),
              )
            ],
          )
        ],
      ))),
    );
  }

  Container movingBar() {
    return Container(
      height: 5,
      margin: EdgeInsets.symmetric(horizontal: 95, vertical: 20),
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: klightGrey),
    );
  }

  Widget slidingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: kwhiteGrey),
    );
  }

  void onAddButtonTappedNext() {
    controller.nextPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }
}
