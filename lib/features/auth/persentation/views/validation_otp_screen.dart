import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/features/auth/persentation/cubits/cubit/auth_cubit.dart';
import 'package:laza_ecommerce/features/auth/persentation/views/signin_screen.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/title_widget.dart';

class ValidationOtpScreen extends StatefulWidget {
  final String email;
  const ValidationOtpScreen({super.key, required this.email});

  @override
  State<ValidationOtpScreen> createState() => _ValidationOtpScreenState();
}

class _ValidationOtpScreenState extends State<ValidationOtpScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String get otp => _controllers.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerificationLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is OtpVerificationSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP verified successfully!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        } else if (state is OtpVerificationFailure) {
          Navigator.pop(context); 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleWidget(title: "Verification Code"),
              SizedBox(height: 48.h),
              Image.asset('assets/images/IMG.png', height: 250),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return _buildCodeBox(context, index);
                }),
              ),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: CustomButtonNavBar(
          text: '00:20 resend confirmation code.',
          label: '',
          textFixed: 'Validate Otp',
          onTap: () {
            if (otp.length == 6) {
              context.read<AuthCubit>().verifyOtp(email: widget.email, otp: otp);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter the full OTP')),
              );
            }
          },
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildCodeBox(BuildContext context, int index) {
    return Container(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color.fromARGB(255, 214, 215, 218)),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          onChanged: (value) {
            if (value.length == 1 && index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }
}