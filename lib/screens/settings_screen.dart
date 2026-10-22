import 'package:flutter/material.dart';
import 'package:quizyuk/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _editName(BuildContext context) async {
    final user = context.read<UserProvider>();
    final controller = TextEditingController(text: user.name);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ubah nama'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nama'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) await user.setName(result);
  }

  Future<void> _reset(BuildContext context) async {
    final quiz = context.read<QuizProvider>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset progres?'),
        content: const Text('Semua nilai terbaik akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (ok == true) {
      quiz.resetAfterClear();
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Progres direset')));
      }
    }
  }

  Future<void> _forgetAllPreferences(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.wrong,
          size: 40,
        ),
        title: const Text('Hapus semua data?'),
        content: const Text(
          'Semua data pengguna, progres kuis, dan pengaturan '
          'yang tersimpan akan dihapus. Tindakan ini tidak '
          'dapat dibatalkan.',
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Batal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.wrong,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: const Text(
                    'Hapus Semua',
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // Berhenti jika pengguna membatalkan.
    if (confirm != true || !context.mounted) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!context.mounted) return;

      // Reset state provider agar UI ikut diperbarui.
      context.read<UserProvider>().resetAfterClear();
      context.read<QuizProvider>().resetAfterClear();
      context.read<ThemeProvider>().resetAfterClear();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        (route) => false,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal menghapus data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final user = context.watch<UserProvider>();
    final brand = AppColors.brand(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: SafeArea(
        child: ContentWidth(
          child: ListView(
            children: [
              SwitchListTile(
                secondary: Icon(Icons.dark_mode_rounded, color: brand),
                title: const Text('Mode Gelap'),
                subtitle: Text(
                  theme.isDark ? 'Dark Mode aktif' : 'Light Mode aktif',
                ),
                value: theme.isDark,
                activeColor: AppColors.mint,
                onChanged: theme.setDark,
              ),
              ListTile(
                leading: Icon(Icons.person_rounded, color: brand),
                title: const Text('Ubah nama'),
                subtitle: Text(user.name),
                onTap: () => _editName(context),
              ),
              ListTile(
                leading: const Icon(Icons.restore, color: AppColors.wrong),
                title: const Text('Reset progres kuis'),
                onTap: () => _reset(context),
              ),

              ListTile(
                leading: const Icon(
                  Icons.delete_forever,
                  color: AppColors.wrong,
                ),
                title: const Text('Hapus data pengguna'),
                onTap: () => _forgetAllPreferences(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
