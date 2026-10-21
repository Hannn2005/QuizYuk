import 'package:flutter/material.dart';
import 'question.dart';

class QuizCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<Question> questions;
  const QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.questions,
  });
}
