import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import './screens/topPage_Screen.dart';
import './screens/game_Screen.dart';
import './screens/ranking_screen.dart';
import './screens/scoreResult_Screen.dart';
import './screens/select_player.dart';
import './providers/user_scores.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserScores(),
      child: MaterialApp(
        title: 'Nonoshire',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TopPageMenu(),
        routes: {
          TopPageMenu.routeName: (ctx) => TopPageMenu(),
          GameScreen.routeName: (ctx) => GameScreen(),
          Ranking.routeName: (ctx) => Ranking(),
          ScoreResult.routeName: (ctx) => ScoreResult(),
          SelectPlayer.routeName: (ctx) => SelectPlayer(),
        },
      ),
    );
  }
}
