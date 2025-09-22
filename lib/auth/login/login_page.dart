import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Components/MyButton.dart';
import '../../Components/text_field.dart';
import '../../Components/them_button.dart';
import '../../screens/Homepage/HomeView.dart';
import '../signing/signuppage.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const ThemeButton(),
              const SizedBox(height: 30),
              Row(
                children: const [
                  Text(
                    "Welcome Back !",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text(
                    "Sign to continue your journey",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                emailController: loginVM.emailController,
                validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: true,
                emailController: loginVM.passwordController,
                validator: (value) =>
                    value!.isEmpty ? "Enter your password" : null,
                hintText: 'Password',
              ),
              const SizedBox(height: 20),
              loginVM.loading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () async {
                        final user = await loginVM.login(context);
                        if (user != null && context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: MyButton(text: 'Login'),
                    ),
              const Spacer(),
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
