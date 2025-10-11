import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/app_theme.dart';

class CustomButtonNavBar extends StatelessWidget {
  final String label;
  final String? text;
  final String textFixed;
  final void Function()? onPressed;
  final void Function() onTap;

  const CustomButtonNavBar({
    super.key,
    required this.label,
    this.text,
    required this.textFixed,
    this.onPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(10.0.r),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.colorGray,
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  text ?? '',

                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textColor1,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 15.h),

        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 75.h,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.mainColor),
            child: Text(
              textFixed,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
