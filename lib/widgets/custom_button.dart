import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Make sure to import the necessary packages

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool? inProgress;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? textSize;
  final Color? textColor;
  final Color? backgroundColor;
  final double? borderradius;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.inProgress,
    this.buttonHeight,
    this.buttonWidth,
    this.textColor,
    this.textSize,
    this.backgroundColor,
    this.borderradius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      // decoration: BoxDecoration(color: AppColors.buttonColor),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderradius ?? 0)))),
            backgroundColor:
                MaterialStateProperty.all<Color?>(backgroundColor)),
        onPressed: onPressed,
        child: inProgress ?? false
            ? const CustomCircularProgressIndidator()
            : TextWidget(
                text: buttonText,
                fontSize: textSize ?? 18.sp,
                color: textColor,
              ),
      ),
    );
  }
}
