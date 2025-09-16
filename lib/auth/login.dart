import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_ecommerce/auth/signingpage.dart';
import '../Components/MyButton.dart';
import '../Components/text_field.dart';
import '../Components/them_button.dart';
import '../screens/home page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), actions: [ThemeButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  const Text(
                    "Welcome Back !",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Sign to continue your journey",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                emailController: _emailController,
                validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: true,
                emailController: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? "Enter your password" : null,
                hintText: 'Password',
              ),

              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : InkWell(onTap: _login, child: MyButton()),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
