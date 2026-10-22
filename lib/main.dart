import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = UserProvider();
  final theme = ThemeProvider();
  final quiz = QuizProvider();
  await Future.wait([user.load(), theme.load(), quiz.load()]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: user),
      ChangeNotifierProvider.value(value: theme),
      ChangeNotifierProvider.value(value: quiz),
    ],
    child: const QuizYukApp(),
  ));
}

class QuizYukApp extends StatelessWidget {
  const QuizYukApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;
    return MaterialApp(
      title: 'QuizYuk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
