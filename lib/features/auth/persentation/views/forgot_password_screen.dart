// lib/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Forgot Password", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 48),
            // Add your cloud/lock image here from assets
            Image.asset('assets/cloud_lock.png', height: 150), 
            const SizedBox(height: 48),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email Address"),
            ),
            const SizedBox(height: 24),
            Text(
              "Please write your email to receive a confirmation code to set a new password.",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Confirm Mail"),
            ),
          ],
        ),
      ),
    );
  }
}