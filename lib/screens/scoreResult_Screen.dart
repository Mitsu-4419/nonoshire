import 'dart:async';

import 'package:Nonoshire/screens/topPage_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './game_Screen.dart';
import './ranking_screen.dart';
import '../providers/user_scores.dart';
import '../models/score.dart';
import '../screens/topPage_Screen.dart';

class ScoreResult extends StatefulWidget {
  static const routeName = '/scoreResult';

  @override
  _ScoreResultState createState() => _ScoreResultState();
}

class _ScoreResultState extends State<ScoreResult>
    with TickerProviderStateMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  int _userScore = 0;
  String imagePath = '';
  String serifuPath = '';
  Future<int> _score;
  int bestScore = 0;
  int prevScore;
  int routeScore;
  bool _hasPadding_score = true;
  bool _hasPadding_bestscore = true;
  bool retrybutton_bool = true;
  bool obasanButton = true;
  var _isSmall = true;
  final List<String> pathArray = [
    'Assets/faces/woman/meanWoman1.png',
    'Assets/faces/woman/meanWoman2.png',
    'Assets/faces/woman/surpriseWoman1.png',
    'Assets/faces/woman/surpriseWoman2.png',
    'Assets/faces/woman/screamWoman1.png',
    'Assets/faces/woman/screamWoman2.png',
    'Assets/faces/woman/fearWoman1.png',
    'Assets/faces/woman/fearWoman2.png',
    'Assets/faces/woman/cryingWoman.png',
    'Assets/faces/woman/cryingWoman2.png',
  ];

  final List<String> serifuPathArray = [
    'Assets/serifu/woman_serifu_after/serifu_after_1.png',
    'Assets/serifu/woman_serifu_after/serifu_after_2.png',
    'Assets/serifu/woman_serifu_after/serifu_after_3.png',
    'Assets/serifu/woman_serifu_after/serifu_after_4.png',
    'Assets/serifu/woman_serifu_after/serifu_after_5.png',
  ];

  var _alignment = _alignments[0];
  static const _alignments = [
    Alignment(1.0, -1.0),
    Alignment(0.0, -1.0),
  ];

  final Shader _linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xfff0ff00),
      Color(0xfff8f8ff),
    ],
  ).createShader(
    Rect.fromLTWH(
      0.0,
      0.0,
      250.0,
      70.0,
    ),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _alignment = _alignments[1];
      });
    });
    new Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _hasPadding_score = !_hasPadding_score;
      });
    });

    new Timer(const Duration(milliseconds: 1200), () {
      setState(() {
        _hasPadding_bestscore = !_hasPadding_bestscore;
      });
    });
    new Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        retrybutton_bool = !retrybutton_bool;
      });
    });
    new Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        obasanButton = !obasanButton;
        _isSmall = !_isSmall;
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeScore = (ModalRoute.of(context).settings.arguments as Map)['score'];

    _prefs.then((SharedPreferences prefs) {
      bestScore = (prefs.getInt('best_score') ?? 0);
      if (bestScore < routeScore) {
        prefs.setInt('best_score', routeScore);
      }
      return bestScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final routeScore =
    //     (ModalRoute.of(context).settings.arguments as Map)['score'];
    final scoreOfUser = Provider.of<UserScores>(context);
    // getData().then((value) => prevScore = value);
    if (routeScore < 15) {
      imagePath = pathArray[0];
    } else if (routeScore < 35) {
      imagePath = pathArray[1];
      serifuPath = serifuPathArray[0];
    } else if (routeScore < 55) {
      imagePath = pathArray[2];
    } else if (routeScore < 75) {
      serifuPath = serifuPathArray[1];
      imagePath = pathArray[3];
    } else if (routeScore < 100) {
      imagePath = pathArray[4];
    } else if (routeScore < 125) {
      serifuPath = serifuPathArray[2];
      imagePath = pathArray[5];
    } else if (routeScore < 150) {
      imagePath = pathArray[6];
    } else if (routeScore < 175) {
      serifuPath = serifuPathArray[3];
      imagePath = pathArray[7];
    } else if (routeScore < 200) {
      imagePath = pathArray[8];
      serifuPath = serifuPathArray[4];
    } else if (routeScore > 199) {
      imagePath = pathArray[8];
      serifuPath = serifuPathArray[5];
    }
    if (routeScore < 35) {
      serifuPath = serifuPathArray[0];
    } else if (routeScore < 75) {
      serifuPath = serifuPathArray[1];
    } else if (routeScore < 125) {
      serifuPath = serifuPathArray[2];
    } else if (routeScore < 175) {
      serifuPath = serifuPathArray[3];
    } else if (routeScore < 200) {
      serifuPath = serifuPathArray[4];
    } else if (routeScore > 199) {
      serifuPath = serifuPathArray[5];
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('Assets/background/Nonoshire_end_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedAlign(
                    alignment: _alignment,
                    duration: const Duration(milliseconds: 400),
                    child: BorderedText(
                      strokeWidth: 4,
                      strokeColor: Colors.red,
                      child: Text(
                        "Score",
                        style: TextStyle(
                          fontSize: 43.0,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 600),
                      style: TextStyle(fontSize: _hasPadding_score ? 0 : 80),
                      curve: Curves.easeInOutBack,
                      child: BorderedText(
                        strokeWidth: 5,
                        strokeColor: Colors.red,
                        child: Text(
                          routeScore.toString(),
                          style: TextStyle(
                            foreground: Paint()..shader = _linearGradient,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<int>(
                    future: _score,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          print("snapshotData${snapshot.data}");
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data == null ||
                              snapshot.data < routeScore) {
                            return Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 700),
                                    style: TextStyle(
                                        fontSize:
                                            _hasPadding_bestscore ? 0 : 30),
                                    curve: Curves.elasticOut,
                                    child: BorderedText(
                                      strokeWidth: 2,
                                      strokeColor: Colors.white,
                                      child: Text(
                                        'Best',
                                        style: TextStyle(
                                          // fontSize: 30.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 700),
                                    style: TextStyle(
                                        fontSize:
                                            _hasPadding_bestscore ? 0 : 30),
                                    curve: Curves.elasticOut,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.red,
                                      child: Text(
                                        "$routeScore",
                                        style: TextStyle(
                                          // fontSize: 30.0,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.data > routeScore) {
                            return Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 700),
                                    style: TextStyle(
                                        fontSize:
                                            _hasPadding_bestscore ? 0 : 30),
                                    curve: Curves.elasticOut,
                                    child: BorderedText(
                                      strokeWidth: 2,
                                      strokeColor: Colors.white,
                                      child: Text(
                                        'Best',
                                        style: TextStyle(
                                          // fontSize: 30.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 700),
                                    style: TextStyle(
                                        fontSize:
                                            _hasPadding_bestscore ? 0 : 30),
                                    curve: Curves.elasticOut,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.red,
                                      child: Text(
                                        "${snapshot.data}",
                                        style: TextStyle(
                                          // fontSize: 30.0,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AnimatedSize(
                    vsync: this,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    // padding: EdgeInsets.all(retrybutton_bool ? 40 : 0),
                    child: GestureDetector(
                      child: Container(
                        width: _isSmall ? 0 : 200,
                        height: 86,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/button/retryButton.png'),
                            fit: BoxFit.cover,
                          ), // button text
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSize(
                        vsync: this,
                        duration: const Duration(milliseconds: 50),
                        curve: Curves.ease,
                        child: GestureDetector(
                          child: Container(
                              width: _isSmall ? 0 : 175,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'Assets/button/registerButton.png'),
                                  fit: BoxFit.cover,
                                ), // button text
                              )),
                          onTap: () {
                            _showMyDialog(
                                context, routeScore, scoreOfUser.addProduct);
                            // Navigator.of(context).pushNamed(Ranking.routeName);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                        child: GestureDetector(
                          child: Container(
                              width: _isSmall ? 0 : 110,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('Assets/button/topButton.png'),
                                  fit: BoxFit.cover,
                                ), // button text
                              )),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(TopPageMenu.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      AnimatedSize(
                        vsync: this,
                        curve: Curves.easeInOutBack,
                        duration: Duration(milliseconds: 500),
                        child: SizedBox(
                          width: _isSmall ? 0 : 300,
                          height: 120,
                          child: Image.asset(
                            imagePath,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 18,
                        child: AnimatedSize(
                          vsync: this,
                          curve: Curves.easeInOutBack,
                          duration: Duration(milliseconds: 500),
                          child: SizedBox(
                            width: _isSmall ? 0 : 90,
                            child: Image.asset(
                              serifuPath,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(
      BuildContext ctx, int score, Function addScore) async {
    return showDialog<void>(
      context: ctx,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('名前をいれてください',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 3) {
                        return "２文字以上でお願いします";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'ニックネーム'),
                    onSaved: (value) {
                      _userName = value;
                      _userScore = score;
                    },
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ランキングへ'),
              onPressed: () async {
                final isValid = _formKey.currentState.validate();
                if (isValid) {
                  _formKey.currentState.save();
                  UserScore sendObj =
                      UserScore(name: _userName, score: _userScore);
                  await addScore(sendObj);
                  Navigator.pushAndRemoveUntil(
                    ctx,
                    MaterialPageRoute(builder: (ctx) => Ranking()),
                    (Route<dynamic> route) => false,
                  );
                  // Navigator.pushReplacementNamed(ctx, Ranking.routeName);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
