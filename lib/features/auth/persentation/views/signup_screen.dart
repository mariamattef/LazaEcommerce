import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/app_theme.dart';
import 'package:laza_ecommerce/features/auth/persentation/cubits/cubit/auth_cubit.dart';
import 'package:laza_ecommerce/features/auth/persentation/views/signin_screen.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_text_form_field.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/title_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
       
        } else if (state is AuthFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleWidget(title: "Sign Up"),
              SizedBox(height: 100.h),
              CustomTextFormField(
                controller: firstNameController,
                labelText: 'Firstname',
                suffixIcon: const Icon(Icons.check),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: lastNameController,
                labelText: 'Lastname',
                suffixIcon: const Icon(Icons.check),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: passwordController,
                labelText: 'Password',
                suffixIcon: Text(
                  'strong',
                  style: TextStyle(color: AppTheme.secondryColor),
                ),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email Address',
                suffixIcon: const Icon(Icons.check),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
        bottomNavigationBar: CustomButtonNavBar(
          label: "Already have an account?",
          text: 'Sign In',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignInScreen()),
            );
          },
          textFixed: 'Sign Up',
          onTap: () {
            context.read<AuthCubit>().signUp(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              password: passwordController.text,
            );
          },
        ),
      ),
    );
  }
}
