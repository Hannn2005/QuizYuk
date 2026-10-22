import 'package:flutter/material.dart';
import '../models/quiz_category.dart';
import '../theme/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final QuizCategory category;
  final int? bestScore;
  final VoidCallback onStart;
  const CategoryCard(
      {super.key, required this.category, this.bestScore, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.brand(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: brand.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: AppColors.mint.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(category.icon, color: brand),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.title,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800, color: brand)),
                    const SizedBox(height: 2),
                    Text(category.description,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.help_outline_rounded, size: 18, color: brand),
              const SizedBox(width: 4),
              Text('${category.questions.length} soal'),
              const SizedBox(width: 14),
              Icon(Icons.emoji_events_outlined, size: 18, color: brand),
              const SizedBox(width: 4),
              Text(bestScore == null ? 'Belum dicoba' : 'Terbaik: $bestScore%'),
              const Spacer(),
              FilledButton(
                onPressed: onStart,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Mulai'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
