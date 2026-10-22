import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuizProgress extends StatelessWidget {
  final int current;
  final int total;
  const QuizProgress({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Soal $current dari $total',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: AppColors.brand(context))),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: current / total,
            minHeight: 8,
            color: AppColors.mint,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
          ),
        ),
      ],
    );
  }
}
