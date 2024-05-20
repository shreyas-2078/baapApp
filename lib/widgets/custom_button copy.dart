// ignore_for_file: file_names

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_circular_progress_indicator.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton(
      {super.key,
      this.onPress,
      this.inProgress,
      this.buttonText,
      this.color,
      this.buttonTextSize,
      this.borderRadius = 5.0,
      this.textColor,
      this.height = 45,
      this.width,
      this.fontWeight});

  final VoidCallback? onPress;
  final bool? inProgress;
  final String? buttonText;
  final double borderRadius;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? color;
  final bool? fontWeight;
  double? buttonTextSize = 16.sp;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.color ?? const Color.fromARGB(255, 215, 214, 214),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            )),
        child: (widget.inProgress ?? false)
            ? const CustomCircularProgressIndidator()
            : TextWidget(
                text: widget.buttonText,
                fontSize: widget.buttonTextSize,
                color: widget.textColor ?? AppColors.backgroundLight,
                fontWeight: widget.fontWeight != null ? FontWeight.bold : null,
              ),
      ),
    );
  }
}
