import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({super.key, this.firstWidget, this.secondWidget});

  final Widget? firstWidget;
  final Widget? secondWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 304.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.backgroundLight,
              child: firstWidget,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.backgroundDark,
                child: secondWidget,
              ),
            ),
          ],
        ),
        bottomNavigationBar: _footerText(),
      ),
    );
  }

  _footerText() {
    return Container(
      color: AppColors.backgroundDark,
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Made in Paregaon LIVE with ',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                  text: 'Pride ',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPinkColor),
                ),
              ])),
        ],
      ),
    );
  }
}
