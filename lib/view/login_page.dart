
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/social_button.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Exibe mensagens para o usuário
  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Recuperação de senha
  Future<void> forgotPassword() async {
    if (emailController.text.trim().isEmpty) {
      showAlert('Digite seu email primeiro.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      showAlert('Enviamos um link para seu email!');
    } on FirebaseAuthException {
      if (!mounted) return;

      showAlert('Não foi possível enviar o email. Tente novamente.');
    }
  }

  // Realiza o login
  Future<void> signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showAlert('Preencha o email e a senha.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      Navigator.pop(context);

      showAlert(
        switch (e.code) {
          'invalid-credential' => 'Email ou senha incorretos.',
          _ => 'Não foi possível entrar. Tente novamente.',
        },
      );
    } catch (_) {
      if (!mounted) return;

      Navigator.pop(context);
      showAlert('Ocorreu um erro inesperado. Tente novamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.lock_rounded,
                  size: 90,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Bem-vindo de volta!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                TextButton(
                  onPressed: forgotPassword,
                  child: const Text('Esqueceu a senha?'),
                ),

                MyButton(
                  onTap: signIn,
                  text: 'Entrar',
                  icon: Icons.login,
                ),

                const SizedBox(height: 25),

                const Text('ou continue com'),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      SocialButton(
                        icon: Icons.g_mobiledata,
                        label: 'Google',
                        onTap: () {},
                      ),

                      const SizedBox(width: 12),

                      SocialButton(
                        icon: Icons.apple,
                        label: 'Apple',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterPage(),
                    ),
                  ),
                  child: const Text('Registre-se agora'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
