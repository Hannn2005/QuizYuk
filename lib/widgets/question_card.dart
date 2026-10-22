import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuestionCard extends StatelessWidget {
  final String text;
  const QuestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.brand(context).withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 18,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: AppColors.brand(context))),
    );
  }
}
