import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
// import 'package:flutter/services.dart';
import './blinkingWidget.dart';

class FaceImageWoman extends StatefulWidget {
  final int _score;
  final int _damageCount;

  FaceImageWoman(this._score, this._damageCount);
  @override
  _FaceImageWomanState createState() => _FaceImageWomanState();
}

class _FaceImageWomanState extends State<FaceImageWoman>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _damageEnabled1 = false;
  bool _damageEnabled2 = false;
  bool _damageEnabled3 = false;
  bool _damageEnabled4 = false;
  bool damageBlink = false;
  bool _serifFlag1 = false;
  bool _serifFlag2 = false;
  bool _serifFlag3 = false;
  bool _serifFlag4 = false;
  bool _serifFlag5 = false;
  bool _serifFlag6 = false;
  bool _serifFlag7 = false;
  bool _serifFlag8 = false;
  bool _serifFlag9 = false;
  bool timer1 = false;
  bool timer2 = false;
  bool timer3 = false;
  bool timer4 = false;
  bool timer5 = false;
  bool timer6 = false;
  bool timer7 = false;
  bool timer8 = false;
  bool timer9 = false;
  final List<String> serifPathArray = [
    'Assets/serifu/woman_serifu/serifu_0.png',
    'Assets/serifu/woman_serifu/serifu_1_1.png',
    'Assets/serifu/woman_serifu/serifu_1_2.png',
    'Assets/serifu/woman_serifu/serifu_1_3.png',
    'Assets/serifu/woman_serifu/serifu_2_1.png',
    'Assets/serifu/woman_serifu/serifu_2_2.png',
    'Assets/serifu/woman_serifu/serifu_2_3.png',
    'Assets/serifu/woman_serifu/serifu_2_4.png',
    'Assets/serifu/woman_serifu/serifu_3_1.png',
    'Assets/serifu/woman_serifu/serifu_3_2.png',
    'Assets/serifu/woman_serifu/serifu_4_1.png',
    'Assets/serifu/woman_serifu/serifu_4_2.png',
    'Assets/serifu/woman_serifu/serifu_4_3.png',
    'Assets/serifu/woman_serifu/serifu_4_4.png',
    'Assets/serifu/woman_serifu/serifu_5_1.png',
    'Assets/serifu/woman_serifu/serifu_5_2.png',
    'Assets/serifu/woman_serifu/serifu_5_3.png',
    'Assets/serifu/woman_serifu/serifu_5_4.png',
    'Assets/serifu/woman_serifu/serifu_6_1.png',
    'Assets/serifu/woman_serifu/serifu_6_2.png',
    'Assets/serifu/woman_serifu/serifu_6_3.png',
    'Assets/serifu/woman_serifu/serifu_7_1.png',
    'Assets/serifu/woman_serifu/serifu_7_2.png',
    'Assets/serifu/woman_serifu/serifu_8_1.png',
    'Assets/serifu/woman_serifu/serifu_8_2.png',
    'Assets/serifu/woman_serifu/serifu_9_1.png',
    'Assets/serifu/woman_serifu/serifu_9_2.png',
    'Assets/serifu/woman_serifu/serifu_9_3.png'
  ];
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
  final List<double> faceSizeNumArray = [
    300,
    295,
    290,
    290,
    310,
    290,
    280,
    270,
    250,
    240,
    230,
    210
  ];
  final List<double> faceSizeSrinkNumArray = [
    290,
    292,
    287,
    287,
    305,
    286,
    275,
    265,
    240,
    230,
    220,
    200
  ];
  var imagePath = '';
  var serifPath = '';
  var direction = "left";
  var faceSize = 0.0;
  var faceSizeSrink = 0.0;
  int prevScore = 0;

  @override
  void initState() {
    super.initState();
    imagePath = pathArray[0];
    serifPath = serifPathArray[0];
    faceSize = faceSizeNumArray[0];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(FaceImageWoman oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    super.didChangeDependencies();
    print(widget._score);
    print(widget._damageCount);
    // ==========================
    // 得点に応じて顔の表情を変化させる
    // =========================
    if (widget._damageCount > 2) {
      Vibration.vibrate();
    }
    var random = new math.Random();
    print("prev$prevScore");
    if (prevScore != widget._score) {
      if (widget._score < 15) {
        setState(() {
          imagePath = pathArray[0];
          if (_serifFlag1 == false) {
            serifPath = serifPathArray[random.nextInt(3) + 1];
            _serifFlag1 = true;
          } else {
            if (timer1 == false) {
              timer1 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag1 = false;
                timer1 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[0];
          faceSizeSrink = faceSizeSrinkNumArray[0];
        });
        direction = 'left';
      } else if (widget._score < 35) {
        setState(() {
          imagePath = pathArray[1];
          if (_serifFlag2 == false) {
            serifPath = serifPathArray[random.nextInt(4) + 4];
            _serifFlag2 = true;
          } else {
            if (timer2 == false) {
              timer2 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag2 = false;
                timer2 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[1];
          faceSizeSrink = faceSizeSrinkNumArray[1];
        });
        direction = 'right';
      } else if (widget._score < 55) {
        setState(() {
          imagePath = pathArray[2];
          if (_serifFlag3 == false) {
            serifPath = serifPathArray[random.nextInt(2) + 8];
            _serifFlag3 = true;
          } else {
            if (timer3 == false) {
              timer3 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag3 = false;
                timer3 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[2];
          faceSizeSrink = faceSizeSrinkNumArray[2];
        });
        direction = 'left';
      } else if (widget._score < 75) {
        setState(() {
          imagePath = pathArray[3];
          if (_serifFlag4 == false) {
            serifPath = serifPathArray[random.nextInt(4) + 10];
            _serifFlag4 = true;
          } else {
            if (timer4 == false) {
              timer4 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag4 = false;
                timer4 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[3];
          faceSizeSrink = faceSizeSrinkNumArray[3];
        });
        direction = 'right';
      } else if (widget._score < 100) {
        setState(() {
          imagePath = pathArray[4];
          if (_serifFlag5 == false) {
            serifPath = serifPathArray[random.nextInt(4) + 14];
            _serifFlag5 = true;
          } else {
            if (timer5 == false) {
              timer5 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag5 = false;
                timer5 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[4];
          faceSizeSrink = faceSizeSrinkNumArray[4];
        });
        direction = 'left';
      } else if (widget._score < 125) {
        setState(() {
          imagePath = pathArray[5];
          if (_serifFlag6 == false) {
            serifPath = serifPathArray[random.nextInt(3) + 18];
            _serifFlag6 = true;
          } else {
            if (timer6 == false) {
              timer6 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag6 = false;
                timer6 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[5];
          faceSizeSrink = faceSizeSrinkNumArray[5];
        });
        direction = 'right';
      } else if (widget._score < 150) {
        setState(() {
          imagePath = pathArray[6];
          if (_serifFlag7 == false) {
            serifPath = serifPathArray[random.nextInt(2) + 21];
            _serifFlag7 = true;
          } else {
            if (timer7 == false) {
              timer7 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag7 = false;
                timer7 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[6];
          faceSizeSrink = faceSizeSrinkNumArray[6];
        });
        direction = 'right';
      } else if (widget._score < 175) {
        setState(() {
          imagePath = pathArray[7];
          if (_serifFlag8 == false) {
            serifPath = serifPathArray[random.nextInt(2) + 23];
            _serifFlag8 = true;
          } else {
            if (timer8 == false) {
              timer8 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag8 = false;
                timer8 = false;
              });
            }
          }
          faceSize = faceSizeNumArray[7];
          faceSizeSrink = faceSizeSrinkNumArray[7];
        });
        direction = 'left';
      } else if (widget._score < 200) {
        setState(() {
          imagePath = pathArray[8];
          faceSize = faceSizeNumArray[8];
          faceSizeSrink = faceSizeSrinkNumArray[8];
          if (_serifFlag9 == false) {
            serifPath = serifPathArray[random.nextInt(3) + 25];
            _serifFlag9 = true;
          } else {
            if (timer9 == false) {
              timer9 = true;
              new Timer(const Duration(seconds: 3), () {
                _serifFlag9 = false;
                timer9 = false;
              });
            }
          }
        });
        direction = 'right';
      } else if (widget._score > 199) {
        setState(() {
          imagePath = pathArray[9];
          faceSize = faceSizeNumArray[9];
          faceSizeSrink = faceSizeSrinkNumArray[9];
        });
      }
      // =============================================
      // ダメージに応じてダメージ画像を表示させる
      // =============================================
      if (widget._damageCount == 1) {
        setState(
          () {
            if (_damageEnabled1 == false) {
              _damageEnabled1 = true;
              new Timer(const Duration(milliseconds: 500), () {
                _damageEnabled1 = false;
              });
            }
          },
        );
      } else if (widget._damageCount == 2) {
        setState(
          () {
            if (_damageEnabled2 == false) {
              _damageEnabled2 = true;
              new Timer(const Duration(milliseconds: 500), () {
                _damageEnabled2 = false;
              });
            }
          },
        );
      } else if (widget._damageCount == 3) {
        setState(
          () {
            if (_damageEnabled3 == false) {
              _damageEnabled3 = true;
              new Timer(const Duration(milliseconds: 500), () {
                _damageEnabled3 = false;
              });
            }
          },
        );
      } else if (widget._damageCount == 4) {
        setState(
          () {
            if (_damageEnabled4 == false) {
              _damageEnabled4 = true;
              new Timer(const Duration(milliseconds: 300), () {
                _damageEnabled4 = false;
              });
            }
          },
        );
      }
    }
    prevScore = widget._damageCount;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Transform.scale(
            scale: 1.0,
            child: Hero(
              tag: 'woman',
              child: BlinkWidget(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Image.asset(
                      imagePath,
                      width: faceSize,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Opacity(
                      opacity: 0.95,
                      child: Image.asset(
                        imagePath,
                        width: faceSizeSrink,
                      ),
                    ),
                  ),
                ],
                damagingCount: widget._damageCount,
              ),
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 0,
          child: ScaleTransition(
            scale: _animationController.drive(
              Tween<double>(
                begin: 1,
                end: 1.1,
              ),
            ),
            child: AnimatedOpacity(
              opacity: this.direction == 'left' ? 1.0 : 0.0,
              duration: Duration(milliseconds: 50),
              child: Image.asset(
                serifPath,
                width: 165,
                height: 130,
              ),
            ),
          ),
        ),
        ScaleTransition(
          scale: _animationController.drive(
            Tween<double>(
              begin: 1,
              end: 1.1,
            ),
          ),
          child: Align(
            alignment: Alignment(1.0, -1.0),
            child: AnimatedOpacity(
              opacity: this.direction == 'right' ? 1.0 : 0.0,
              duration: Duration(milliseconds: 50),
              child: Image.asset(
                serifPath,
                width: 165,
                height: 120,
              ),
            ),
          ),
        ),
        // ＝＝＝＝＝＝＝＝
        // DamageのWidget
        // ＝＝＝＝＝＝＝＝
        Positioned(
          left: 120.0,
          top: 40,
          child: AnimatedOpacity(
            opacity: this._damageEnabled1 ? 1.0 : 0,
            duration: Duration(milliseconds: 50),
            child: Image.asset('Assets/damage/damage1.png', width: 40),
          ),
        ),
        Positioned(
          right: 120.0,
          top: 40,
          child: AnimatedOpacity(
            opacity: this._damageEnabled2 ? 1.0 : 0,
            duration: Duration(milliseconds: 50),
            child: Image.asset('Assets/damage/damage2.png', width: 40),
          ),
        ),
        Positioned(
          right: 120.0,
          top: 80,
          child: AnimatedOpacity(
            opacity: this._damageEnabled3 ? 1.0 : 0,
            duration: Duration(milliseconds: 50),
            child: Image.asset('Assets/damage/damage3.png', width: 50),
          ),
        ),
        Positioned(
          left: 110.0,
          top: 90,
          child: AnimatedOpacity(
            opacity: this._damageEnabled4 ? 1.0 : 0,
            duration: Duration(milliseconds: 50),
            child: Image.asset('Assets/damage/damage3.png', width: 50),
          ),
        ),
      ],
    );
  }
}
