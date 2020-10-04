import 'package:flutter/material.dart';

class DamageBar extends StatefulWidget {
  int totalDamage;
  DamageBar(this.totalDamage);
  @override
  _DamageBarState createState() => _DamageBarState();
}

class _DamageBarState extends State<DamageBar> {
  Widget build(BuildContext context) {
    var leftLife = 250 - widget.totalDamage;
    return Stack(
      children: [
        Container(
          height: 18,
          width: 251,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.red,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                const Color(0xffff1a1a).withOpacity(0.8),
                const Color(0xffff8100).withOpacity(0.8),
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
        ),
        Container(
          height: 18,
          width: leftLife.toDouble(),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
              bottom: BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
              left: BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
            ),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                const Color(0xff1f9f2e).withOpacity(0.9),
                const Color(0xff00ff1e).withOpacity(0.9),
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
