import 'dart:async';

// import 'package:Nonoshire/screens/game_Screen.dart';
import 'package:Nonoshire/screens/select_player.dart';
import 'package:flutter/material.dart';
// import './game_Screen.dart';
import './ranking_screen.dart';
import './select_player.dart';

class TopPageMenu extends StatefulWidget {
  static const routeName = '/top';

  @override
  _TopPageMenuState createState() => _TopPageMenuState();
}

class _TopPageMenuState extends State<TopPageMenu>
    with TickerProviderStateMixin {
  var _isSmall = true;
  var _alignment = _alignments[0];
  bool _leftIcon = false;
  bool _rightIcon = false;
  static const _alignments = [
    Alignment(30.0, -1.0),
    Alignment(0.0, 0.0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _alignment = _alignments[1];
      });
    });
    new Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _isSmall = !_isSmall;
      });
    });
    new Timer(const Duration(milliseconds: 1600), () {
      setState(() {
        _leftIcon = !_leftIcon;
      });
    });
    new Timer(const Duration(milliseconds: 1800), () {
      setState(() {
        _rightIcon = !_rightIcon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('Assets/background/Nonoshire_top_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                opacity: _leftIcon ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Container(
                    width: 40,
                    child: Image.asset('Assets/Icon/stress_icon_left.png'),
                  ),
                ),
              ),
              Container(
                width: 350,
                child: Image.asset('Assets/background/Nonoshire_title6.png'),
              ),
              AnimatedOpacity(
                opacity: _rightIcon ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Align(
                  alignment: Alignment(0.9, 0.0),
                  child: Container(
                    width: 40,
                    child: Image.asset('Assets/Icon/stress_icon_right.png'),
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: _alignment,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticInOut,
                child: Container(
                  width: 350,
                  child:
                      Image.asset('Assets/background/Nonoshire_subtitle2.png'),
                ),
              ),
              SizedBox(
                height: 85,
              ),
              Container(
                height: 110,
                child: AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  child: GestureDetector(
                    child: Container(
                        width: _isSmall ? 0 : 230,
                        height: _isSmall ? 0 : 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/button/StartButton.png'),
                            fit: BoxFit.cover,
                          ), // button text
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed(SelectPlayer.routeName);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                child: AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  child: GestureDetector(
                    child: Container(
                        width: _isSmall ? 1 : 155,
                        height: _isSmall ? 1 : 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'Assets/button/Ranking_button_top2.png'),
                            fit: BoxFit.cover,
                          ), // button text
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed(Ranking.routeName);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
