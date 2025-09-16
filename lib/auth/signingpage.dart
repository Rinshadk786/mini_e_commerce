import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_ecommerce/Components/MyButton.dart';
import 'package:mini_ecommerce/Components/text_field.dart';
import '../screens/home page.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
              "name": _nameController.text.trim(),
              "email": _emailController.text.trim(),
              "createdAt": DateTime.now(),
            });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signup successful!")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
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
                    "Create an Account!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Join us for Exceptional Experiences",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              CustomTextField(
                emailController: _nameController,
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
                hintText: 'Name',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                emailController: _emailController,
                validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
                hintText: "Email",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                emailController: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? "Enter your password" : null,
                hintText: "Password",
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : InkWell(onTap: _signUp, child: MyButton()),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
