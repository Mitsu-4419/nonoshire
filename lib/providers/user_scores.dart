import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/score.dart';

class UserScores with ChangeNotifier {
  List<UserScore> _scores = [];

  List<UserScore> get scores {
    return [..._scores];
  }

  final docPath = DateTime.now().toString().split(" ")[0];

  Future<void> fetchScores() async {
    _scores = [];
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(docPath)
          .get();
      final List scoreArray = snapshot.data()['ranking'];
      scoreArray.sort((a, b) => b['score'].compareTo(a['score']));
      for (int i = 0; i < scoreArray.length; i++) {
        _scores.add(UserScore(
            name: scoreArray[i]['name'], score: scoreArray[i]['score']));
      }

      notifyListeners();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> addProduct(UserScore userScore) async {
    _scores.add(userScore);
    final now = DateTime.now();
    final docPath = now.toString().split(" ")[0];
    List<dynamic> map = [
      {'name': userScore.name, 'score': userScore.score}
    ];
    try {
      await FirebaseFirestore.instance
          .collection('score')
          .doc(docPath)
          .update({'ranking': FieldValue.arrayUnion(map)});
      notifyListeners();
    } catch (error) {
      print(error);
      await FirebaseFirestore.instance
          .collection('score')
          .doc(docPath)
          .set({'ranking': map});
      notifyListeners();
      throw error;
    }
  }
}
