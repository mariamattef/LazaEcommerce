// lib/screens/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Text("Welcome", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "Please enter your data to continue",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),
            TextFormField(
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 24),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remember me",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value),
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text:
                      "By connecting your account confirm that you agree\nwith our ",
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: "Term and Condition",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      // Add recognizer for tap event
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: () {}, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
