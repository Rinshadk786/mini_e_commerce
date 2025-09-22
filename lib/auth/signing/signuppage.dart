import 'package:flutter/material.dart';
import 'package:mini_ecommerce/auth/signing/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:mini_ecommerce/Components/MyButton.dart';
import 'package:mini_ecommerce/Components/text_field.dart';
import '../../screens/Homepage/HomeView.dart';

import '../login/login_page.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpVM = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: const [
                  Text(
                    "Create an Account!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text(
                    "Join us for Exceptional Experiences",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              CustomTextField(
                emailController: signUpVM.nameController,
                validator: (value) =>
                value!.isEmpty ? "Enter your name" : null,
                hintText: 'Name',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                emailController: signUpVM.emailController,
                validator: (value) =>
                value!.contains("@") ? null : "Enter valid email",
                hintText: "Email",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                emailController: signUpVM.passwordController,
                validator: (value) =>
                value!.isEmpty ? "Enter your password" : null,
                hintText: "Password",
              ),

              const SizedBox(height: 20),
              signUpVM.loading
                  ? const CircularProgressIndicator()
                  : InkWell(
                onTap: () async {
                  final user = await signUpVM.signUp(context);
                  if (user != null && context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
                child: MyButton(text: 'signup',),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue),
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
