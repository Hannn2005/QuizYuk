import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

class QuizProvider extends ChangeNotifier {
  QuizCategory? category;
  int index = 0;
  List<int?> answers = [];
  Map<String, int> best = {}; // id kategori -> nilai terbaik (%)

  List<Question> get questions => category?.questions ?? const [];
  Question get current => questions[index];
  int get total => questions.length;
  bool get isLast => index == total - 1;
  int get answered => answers.whereType<int>().length;

  int get correct {
    var c = 0;
    for (var i = 0; i < total; i++) {
      if (answers[i] == questions[i].answerIndex) c++;
    }
    return c;
  }

  int get wrong => total - correct;
  int get percent => total == 0 ? 0 : (correct * 100 / total).round();

  int get completedCount => best.length;
  int get averageBest => best.isEmpty
      ? 0
      : (best.values.reduce((a, b) => a + b) / best.length).round();

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString('best_scores');
    if (raw != null) {
      best = (jsonDecode(raw) as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as int));
    }
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('best_scores', jsonEncode(best));
  }

  void start(QuizCategory c) {
    category = c;
    index = 0;
    answers = List<int?>.filled(c.questions.length, null);
    notifyListeners();
  }

  void select(int option) {
    answers[index] = option;
    notifyListeners();
  }

  void next() {
    if (!isLast) {
      index++;
      notifyListeners();
    }
  }

  void prev() {
    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  Future<void> submit() async {
    final id = category!.id;
    if (percent > (best[id] ?? -1)) best[id] = percent;
    notifyListeners();
    await _save();
  }

  void resetAfterClear() {
  best.clear();
  category = null;
  index = 0;
  answers = [];
  notifyListeners();
}
}
