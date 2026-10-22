import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AnswerState { idle, selected, correct, wrong }

class AnswerOption extends StatelessWidget {
  final String label;
  final String text;
  final AnswerState state;
  final VoidCallback? onTap;
  const AnswerOption({
    super.key,
    required this.label,
    required this.text,
    this.state = AnswerState.idle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.brand(context);
    Color bg = AppColors.surface(context);
    Color border = brand.withValues(alpha: 0.5);
    Color fg = brand;
    IconData? icon;
    if (state == AnswerState.selected || state == AnswerState.correct) {
      bg = AppColors.mint;
      border = AppColors.mint;
      fg = AppColors.onMint;
      icon = Icons.check_circle_rounded;
    } else if (state == AnswerState.wrong) {
      bg = AppColors.wrong;
      border = AppColors.wrong;
      fg = Colors.white;
      icon = Icons.cancel_rounded;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: border, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(label,
                    style: TextStyle(
                        color: fg, fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(text,
                      style: TextStyle(
                          color: fg, fontWeight: FontWeight.w600, fontSize: 15)),
                ),
                if (icon != null) Icon(icon, color: fg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
