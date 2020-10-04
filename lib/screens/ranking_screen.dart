import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_scores.dart';
import '../widgets/score_list.dart';

class Ranking extends StatefulWidget {
  static const routeName = '/ranking';
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toString().split(" ")[0];
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$today 得点ランキング',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
            Container(
              width: 370,
              height: 500,
              child: FutureBuilder(
                future: Provider.of<UserScores>(context, listen: false)
                    .fetchScores(),
                builder: (ctx, dataSnapshot) {
                  print(dataSnapshot.connectionState);
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (dataSnapshot.error != null) {
                      return Center(
                        child: Text(
                          'No Score!!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Consumer<UserScores>(
                        builder: (ctx, userScores, child) => ListView.builder(
                          itemCount: userScores.scores.length,
                          itemBuilder: (ctx, i) => ScoreList(
                            userScores.scores[i],
                            (i + 1).toString(),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
