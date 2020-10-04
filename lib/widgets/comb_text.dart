import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class CombText extends StatefulWidget {
  final int _givenDamage;
  CombText(this._givenDamage);
  @override
  _CombTextState createState() => _CombTextState();
}

class _CombTextState extends State<CombText>
    with SingleTickerProviderStateMixin {
  AnimationController damageController;
  Animation damageAnimation;
  bool _show = true;
  bool damageDisplay = false;
  int trueDamage = 0;
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() => _show = !_show);
    });
    damageController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..repeat(reverse: true);
    damageAnimation =
        Tween<double>(begin: 40, end: 43).animate(damageController);
  }

  @override
  Widget build(BuildContext context) {
    var damage = widget._givenDamage;
    if (damage > 1) {
      trueDamage = damage;
      damageDisplay = true;
    } else if (damage == 0) {
      counter += 1;
      if (counter > 3 && damageDisplay == true) {
        damageDisplay = false;
        counter = 0;
      }
    }
    return AnimatedBuilder(
      animation: damageAnimation,
      builder: (context, widget) {
        return damage % 2 == 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  BorderedText(
                    strokeWidth: 3,
                    strokeColor: damage % 2 == 0 ? Colors.red : Colors.blue,
                    child: Text(
                      damageDisplay ? '$trueDamage' : '',
                      style: TextStyle(
                          fontSize: damageAnimation.value + 10,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: _show ? Colors.yellow : Colors.white),
                    ),
                  ),
                  BorderedText(
                    strokeWidth: 3,
                    strokeColor: damage % 2 == 0 ? Colors.red : Colors.blue,
                    child: Text(
                      damageDisplay ? 'COMBO!' : '',
                      style: TextStyle(
                        fontSize: damageAnimation.value,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: _show ? Colors.yellow : Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  BorderedText(
                    strokeWidth: 3,
                    strokeColor: damage % 2 == 0 ? Colors.red : Colors.blue,
                    child: Text(
                      damageDisplay ? '$trueDamage' : '',
                      style: TextStyle(
                        fontSize: damageAnimation.value + 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: _show ? Color(0xff8efffc) : Colors.white,
                      ),
                    ),
                  ),
                  BorderedText(
                    strokeWidth: 3,
                    strokeColor: damage % 2 == 0 ? Colors.red : Colors.blue,
                    child: Text(
                      damageDisplay ? 'COMBO' : '',
                      style: TextStyle(
                        fontSize: damageAnimation.value,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: _show ? Color(0xff8efffc) : Colors.white,
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  @override
  void dispose() {
    damageController.dispose();
    super.dispose();
  }
}
