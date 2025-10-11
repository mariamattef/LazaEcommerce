import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/app_theme.dart';
import 'package:laza_ecommerce/features/auth/persentation/cubits/cubit/auth_cubit.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_text_form_field.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/title_widget.dart';
import 'package:laza_ecommerce/features/home/presentation/views/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login  successful!')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
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
          padding:  EdgeInsets.all(24.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               SizedBox(height: 40.h),
              TitleWidget(title: "Welcome"),
              Text(
                "Please enter your data to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colorGray,
                ),
              ),
              SizedBox(height: 100.h),
              CustomTextFormField(
                controller: emailController,
                labelText: 'Email Address',
                suffixIcon: Icon(Icons.check),
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
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor1,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: _rememberMe,
                      onChanged: (value) => setState(() => _rememberMe = value),
                      trackColor: WidgetStatePropertyAll(
                        AppTheme.secondryColor,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 32.h),
            ],
          ),
        ),
        bottomNavigationBar: CustomButtonNavBar(
          label: 'By connecting your account confirm that you agree with our ',
          text: 'Term and Condition',
          textFixed: 'Login',
          onTap: () {
            context.read<AuthCubit>().signIn(
              email: emailController.text,
              password: passwordController.text,
              rememberMe: _rememberMe,
            );
          },
        ),
      ),
    );
  }
}
