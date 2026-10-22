import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  const PrimaryButton(
      {super.key, required this.color, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (icon != null) ...[const SizedBox(width: 8), Icon(icon, size: 20)],
          ],
        ),
      ),
    );
  }
}
