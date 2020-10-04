import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:sound_stream/sound_stream.dart';
// import 'package:flutter_sound/flutter_sound.dart';

import '../widgets/faceImage_woman.dart';
import './scoreResult_Screen.dart';
import '../widgets/countdown.dart';
import '../widgets/comb_text.dart';
import '../widgets/damageBar.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/gameScreen';
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  RecorderStream _recorder = RecorderStream();
  PlayerStream _player = PlayerStream();

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  // List<Uint8List> _micChunks = [];
  // bool _isRecording = false;
  // bool _isPlaying = false;

  // StreamSubscription _recorderStatus;
  // StreamSubscription _playerStatus;
  // StreamSubscription _audioStream;

  bool recognizing = false;
  bool recognizeFinished = false;
  bool started = false;
  bool middleAttack = false;
  bool stoneAnimation = false;
  String text = '';
  int score = 0;
  int damageCount = 0;
  int previousDamage = 0;
  int _timeCount = 3;

  List<String> keywords = [
    "お前",
    "死ね",
    "ボケ",
    "クソ",
    "無能",
    "頭悪",
    "ゴミ",
    "帰れ",
    "ハゲ",
    "ケチ",
    '何様',
    '卑し',
    "醜い",
    '腹たつ',
    '聞いて',
    'しばく',
    '殺',
    'きも',
    'きしょ',
    '汚',
    'ババア',
    'おっさん',
    '何考え',
    '嫌い',
    'おい',
    'うぜー',
    'やる気',
    '消えろ',
    '何回同じ',
    '鬱陶しい',
    'アホ',
    '考えろ',
    'ゴキブリ',
    '反省し',
    'クズ',
    '豚',
    '使えない',
    'いい加減',
    'てめえ',
    '生きてる意味',
    '吐き気',
    '早く',
    'いつまで',
    '意味わから',
    'うんざり',
    'イライラ',
    'イラっ'
  ];

  // コールバック関数
  // 最初のカウントダウンからスタートする関数を呼び出してスタートする
  void callbackStart(BuildContext ctx) {
    if (started == false) {
      streamingRecognize(ctx);
      started = true;
    }
  }

  // タイマー処理の関数
  void startTimer(BuildContext ctx) {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_timeCount < 1) {
            timer.cancel();
            stopRecording(ctx);
          } else {
            _timeCount = _timeCount - 1;
          }
        },
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // Future<void> initPlugin() async {
  //   _recorderStatus = _recorder.status.listen((status) {
  //     if (mounted)
  //       setState(() {
  //         _isRecording = status == SoundStreamStatus.Playing;
  //       });
  //   });
  //   _audioStream = _recorder.audioStream.listen((data) {
  //     if (_isPlaying) {
  //       _player.writeChunk(data);
  //     } else {
  //       _micChunks.add(data);
  //     }
  //   });
  //   _playerStatus = _player.status.listen((status) {
  //     if (mounted)
  //       setState(() {
  //         _isPlaying = status == SoundStreamStatus.Playing;
  //       });
  //   });
  //   await Future.wait([
  //     _recorder.initialize(),
  //     _player.initialize(),
  //   ]);
  // }

  // void _play() async {
  //   await _player.start();

  //   if (_micChunks.isNotEmpty) {
  //     for (var chunk in _micChunks) {
  //       await _player.writeChunk(chunk);
  //     }
  //     _micChunks.clear();
  //   }
  // }

  //  ======================
  // 音声認識でダメージ判定
  // =======================
  void streamingRecognize(BuildContext ctx) async {
    await _recorder.initialize();
    await _recorder.start();
    setState(() {
      recognizing = true;
    });
    // Startした時点で1分間のタイマーをかける
    startTimer(ctx);
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('Assets/JSON/Nonoshire-7b56c8272062.json'))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();
    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _recorder.audioStream);
    responseStream.listen((data) {
      // List<dynamic> damageArray;
      setState(() {
        text =
            data.results.map((e) => e.alternatives.first.transcript).join('\n');
        final damageArray = keywords.where((n) => text.contains(n));
        damageCount = damageArray.length;
        if (damageCount == previousDamage) {
          damageCount = 0;
          recognizeFinished = true;
        } else {
          score += damageCount;
          recognizeFinished = true;
          previousDamage = damageCount;
        }
      });
    }, onDone: () {
      setState(() {
        damageCount = 0;
        recognizing = false;
      });
    });
  }

  void stopRecording(BuildContext ctx) async {
    await _recorder.stop();
    setState(() {
      recognizing = false;
    });
    Navigator.of(ctx).pushNamed(
      ScoreResult.routeName,
      arguments: {"score": score},
    );
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'ja-JP');

  Offset startPoint;
  Offset endPoint;
  @override
  void dispose() {
    super.dispose();
    // _recorderStatus?.cancel();
    // _playerStatus?.cancel();
    // _audioStream?.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('Assets/background/office_bg3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  _printDuration(Duration(seconds: _timeCount)),
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'IBMPlexMono',
                    color: _timeCount > 10 ? Colors.black : Colors.red,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DamageBar(score),
                SizedBox(
                  height: 20,
                ),
                CountDown(callbackStart),
                Expanded(
                  child: Container(
                    child: Text(""),
                  ),
                ),
                FaceImageWoman(score, damageCount),
                // Text(
                //   score.toString(),
                //   style: Theme.of(context).textTheme.bodyText1,
                // ),
                // if (recognizeFinished)
                //   _RecognizeContent(
                //     text: text,
                //   ),
              ],
            ),
          ),
          // ＝＝＝＝＝＝＝＝＝＝＝＝＝＝
          // Combが起きたら表示される文字
          // ＝＝＝＝＝＝＝＝＝＝＝＝＝＝
          Positioned(
            top: 180,
            right: 20,
            child: CombText(damageCount),
          ),
        ],
      ),
    );
  }
}

class _RecognizeContent extends StatelessWidget {
  final String text;
  const _RecognizeContent({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('The text recognized by the Google Speech Api:',
              style: TextStyle(color: Colors.red)),
          SizedBox(
            height: 16.0,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
