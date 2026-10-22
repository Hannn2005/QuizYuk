
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/quiz_data.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import 'quiz_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _start(BuildContext context, QuizCategory c) {
    context.read<QuizProvider>().start(c);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = context.watch<UserProvider>().name;
    final quiz = context.watch<QuizProvider>();
    final brand = AppColors.brand(context);

    final filteredCategories = quizCategories.where((category) {
      return category.id.toLowerCase().contains(
        _searchQuery.trim().toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizYuk'),
        actions: [
          IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ContentWidth(
          child: ListView(
            children: [
              const SizedBox(height: 8),

              Text(
                'Halo, $name!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: brand,
                ),
              ),

              const SizedBox(height: 4),
              const Text('Siap menguji pengetahuanmu hari ini?'),
              const SizedBox(height: 20),

              // Ringkasan progres
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progres kuis',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${quiz.completedCount} dari '
                      '${quizCategories.length} kategori selesai',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: quiz.completedCount /
                            quizCategories.length,
                        minHeight: 8,
                        color: AppColors.mint,
                        backgroundColor:
                            Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rata-rata nilai terbaik: ${quiz.averageBest}%',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Cari Quiz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: brand,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan kategori',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: brand,
                ),
              ),

              const SizedBox(height: 12),

              if (filteredCategories.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text('Kategori tidak ditemukan'),
                  ),
                )
              else
                for (final c in filteredCategories)
                  CategoryCard(
                    category: c,
                    bestScore: quiz.best[c.id],
                    onStart: () => _start(context, c),
                  ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
