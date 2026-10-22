import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/answer_option.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _submit(BuildContext context, QuizProvider q) async {
    if (q.answered < q.total) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Kumpulkan jawaban?'),
          content: Text(
              'Masih ada ${q.total - q.answered} soal belum dijawab dan dihitung salah.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Kembali')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Kumpulkan')),
          ],
        ),
      );
      if (ok != true) return;
    }
    await q.submit();
    if (!context.mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ResultScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final q = context.watch<QuizProvider>();
    final question = q.current;
    final buttonShape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
    return Scaffold(
      appBar: AppBar(title: Text(q.category!.title)),
      body: SafeArea(
        child: ContentWidth(
          child: Column(
            children: [
              const SizedBox(height: 8),
              QuizProgress(current: q.index + 1, total: q.total),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      QuestionCard(text: question.text),
                      const SizedBox(height: 16),
                      for (var i = 0; i < question.options.length; i++)
                        AnswerOption(
                          label: String.fromCharCode(65 + i),
                          text: question.options[i],
                          state: q.answers[q.index] == i
                              ? AnswerState.selected
                              : AnswerState.idle,
                          onTap: () => q.select(i),
                        ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: q.index == 0 ? null : q.prev,
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: buttonShape),
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed:
                          q.isLast ? () => _submit(context, q) : q.next,
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: buttonShape),
                      child: Text(q.isLast ? 'Kumpulkan' : 'Next'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
