
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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

  // Realiza o cadastro
  Future<void> register() async {
    if (passwordController.text != confirmController.text) {
      showAlert('Senhas não conferem!');
      return;
    }

    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showAlert('Preencha todos os campos.');
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pop(context); // Fecha o loading
      Navigator.pop(context); // Fecha a tela de cadastro

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      Navigator.pop(context);

      showAlert(
        switch (e.code) {
          'email-already-in-use' =>
            'Já existe um usuário com esse email!',
          'weak-password' =>
            'Escolha uma senha mais forte.',
          'invalid-email' =>
            'Informe um endereço de email válido.',
          _ => 'Não foi possível cadastrar. Tente novamente.',
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
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Crie sua conta'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

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

              const SizedBox(height: 15),

              MyTextField(
                controller: confirmController,
                hintText: 'Confirmar senha',
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              const SizedBox(height: 25),

              MyButton(
                onTap: register,
                text: 'Registrar',
                icon: Icons.person_add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
