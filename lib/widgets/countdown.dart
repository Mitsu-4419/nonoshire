import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountDown extends StatefulWidget {
  Function startGame;
  CountDown(this.startGame);
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation countdownAnimation;

  int _startTimeCount = 3;
  List wordArray = ["", "Start!", "1", "2", '3'];

  final Shader _linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xfff0ff00),
      Color(0xffff9a00),
    ],
  ).createShader(
    Rect.fromLTWH(
      0.0,
      0.0,
      250.0,
      70.0,
    ),
  );

  // タイマー処理の関数
  void startFirstTimer() {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_startTimeCount < 0) {
            timer.cancel();
          } else {
            _startTimeCount = _startTimeCount - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startFirstTimer();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat(reverse: false);
    countdownAnimation = Tween<double>(begin: 80, end: 50).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (_startTimeCount < 1) {
      widget.startGame(context);
    }
    return AnimatedBuilder(
      animation: countdownAnimation,
      builder: (context, widget) {
        return Align(
          alignment: Alignment.center,
          child: Text(
            wordArray[_startTimeCount + 1],
            style: TextStyle(
                fontSize: countdownAnimation.value,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = _linearGradient),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
