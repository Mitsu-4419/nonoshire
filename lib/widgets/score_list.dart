import 'package:flutter/material.dart';

import '../models/score.dart';

class ScoreList extends StatefulWidget {
  final UserScore userScore;
  final String ranking;

  ScoreList(this.userScore, this.ranking);

  @override
  _ScoreListState createState() => _ScoreListState();
}

class _ScoreListState extends State<ScoreList> {
  String iconImagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (int.parse(widget.ranking) == 1) {
      iconImagePath = 'Assets/Icon/no1_crown.png';
    } else if (int.parse(widget.ranking) == 2) {
      iconImagePath = 'Assets/Icon/no2_crown.png';
    } else if (int.parse(widget.ranking) == 3) {
      iconImagePath = 'Assets/Icon/no3_crown.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: int.parse(widget.ranking) > 3
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ranking,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Image.asset(
                  iconImagePath,
                  width: 40,
                ),
          title: Text(
            widget.userScore.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            widget.userScore.score.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
