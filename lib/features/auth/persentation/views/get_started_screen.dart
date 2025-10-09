// lib/screens/get_started_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza_ecommerce/features/auth/persentation/views/signin_screen.dart';
import 'package:laza_ecommerce/features/auth/persentation/views/signup_screen.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_button_nav_bar.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/custom_icon_elevation_button.dart';
import 'package:laza_ecommerce/features/auth/persentation/widgets/title_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TitleWidget(title: "Let's Get Started"),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomIconElevationButton(
                  backgroundColor: Color(0xFF4267B2),
                  label: "Facebook",
                  icon: SvgPicture.asset('assets/svg/Vector1.svg'),
                  onPressed: () {},
                ),
                SizedBox(height: 16.h),
                CustomIconElevationButton(
                  backgroundColor: const Color(0xFF1DA1F2),
                  label: ' Google',
                  icon: SvgPicture.asset('assets/svg/Twitter.svg'),
                  onPressed: () {},
                ),
                SizedBox(height: 16.h),
                CustomIconElevationButton(
                  backgroundColor: const Color(0xFFEA4335),
                  label: ' Google',
                  icon: SvgPicture.asset('assets/svg/Google.svg'),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),

      bottomNavigationBar: CustomButtonNavBar(
        label: "Already have an account?",
        text: "Signin",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
        textFixed: 'Create an Account',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        },
      ),
    );
  }
}
