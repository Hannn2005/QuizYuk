import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<UserProvider>().setName(_controller.text);
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.brand(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ContentWidth(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/QuizYuk_logo.png',width: 300, height: 150,),
                    const SizedBox(height: 24),
                    Text('Selamat datang di QuizYuk!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: brand)),
                    const SizedBox(height: 8),
                   
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _continue(),
                      decoration: const InputDecoration(
                        labelText: 'Siapa namamu?',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                        color: AppColors.primary,
                        label: 'Lanjut',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _continue),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
