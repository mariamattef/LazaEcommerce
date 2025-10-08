// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/app_theme.dart';
import 'package:laza_ecommerce/features/auth/pesentation/views/login_screen.dart';
import 'package:laza_ecommerce/features/auth/pesentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/auth/pesentation/widgets/custom_text_form_field.dart';
import 'package:laza_ecommerce/features/auth/pesentation/widgets/title_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleWidget(title: "Sign Up"),
            SizedBox(height: 100.h),
            CustomTextFormField(
              labelText: 'Username',
              suffixIcon: Icon(Icons.check),
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              labelText: 'Password',
              suffixIcon: Text(
                'strong',
                style: TextStyle(color: AppTheme.secondryColor),
              ),
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              labelText: 'Email Address',
              suffixIcon: Icon(Icons.check),
            ),

            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remember me",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor1,
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value),
                    trackColor: WidgetStatePropertyAll(AppTheme.secondryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
      bottomNavigationBar: CustomButtonNavBar(
        label: "",
        onPressed: () {},
        textFixed: 'Sign Up',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      ),
    );
  }
}
