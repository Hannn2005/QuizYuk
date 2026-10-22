import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/answer_option.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _message(int p) {
    if (p == 100) return 'Sempurna! 🎉';
    if (p >= 70) return 'Kerja bagus!';
    if (p >= 40) return 'Lumayan, terus berlatih!';
    return 'Jangan menyerah, coba lagi!';
  }

  @override
  Widget build(BuildContext context) {
    final q = context.watch<QuizProvider>();
    final brand = AppColors.brand(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Kuis'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: ContentWidth(
          child: ListView(
            children: [
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text('${q.percent}%',
                        style: const TextStyle(
                            color: AppColors.mint,
                            fontSize: 56,
                            fontWeight: FontWeight.w800)),
                    Text('Skor ${q.correct} / ${q.total}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(_message(q.percent),
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85))),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _chip(Icons.check_circle_rounded, '${q.correct} benar',
                            AppColors.mint, AppColors.onMint),
                        const SizedBox(width: 12),
                        _chip(Icons.cancel_rounded, '${q.wrong} salah',
                            AppColors.wrong, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('Ulasan jawaban',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800, color: brand)),
              const SizedBox(height: 12),
              for (var i = 0; i < q.total; i++) _review(context, q, i),
              const SizedBox(height: 8),
              PrimaryButton(
                color: AppColors.primary,
                label: 'Ulangi Kuis',
                icon: Icons.replay_rounded,
                onPressed: () {
                  q.start(q.category!);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()));
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Kembali ke Home'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String text, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
        ]),
      );

  Widget _review(BuildContext context, QuizProvider q, int i) {
    final question = q.questions[i];
    final picked = q.answers[i];
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
          Text('${i + 1}. ${question.text}',
              style: TextStyle(fontWeight: FontWeight.w700, color: brand)),
          const SizedBox(height: 12),
          for (var o = 0; o < question.options.length; o++)
            AnswerOption(
              label: String.fromCharCode(65 + o),
              text: question.options[o],
              state: o == question.answerIndex
                  ? AnswerState.correct
                  : (o == picked ? AnswerState.wrong : AnswerState.idle),
            ),
          if (picked == null)
            const Text('Tidak dijawab',
                style: TextStyle(color: AppColors.wrong, fontSize: 12)),
        ],
      ),
    );
  }
}
