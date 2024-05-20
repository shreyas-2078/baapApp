import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void openConfirmationDialog({
  required context,
  required title,
  required message,
  required color,
  required positiveButtonText,
  required negativeButtonText,
  required onPositiveButtonClick,
  required onNegativeButtonClick,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  var alertDialog = ConfirmationDialog(
    context: context,
    key: scaffoldKey,
    title: title,
    message: message,
    color: color,
    positiveButtonText: positiveButtonText,
    negativeButtonText: negativeButtonText,
    onPositiveButtonClick: onPositiveButtonClick,
    onNegativeButtonClick: onNegativeButtonClick,
  );
  showDialog(context: context, builder: (context) => alertDialog);
}

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    Key? key,
    required this.context,
    this.scaffoldKey,
    required this.title,
    required this.message,
    this.color,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.onPositiveButtonClick,
    required this.onNegativeButtonClick,
  }) : super(key: key);

  final BuildContext context;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String title;
  final String message;
  final Color? color;
  final String positiveButtonText;
  final String negativeButtonText;
  final Function onPositiveButtonClick;
  final Function onNegativeButtonClick;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.backgroundLight,
      elevation: 16,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: widget.title,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
              fontSize: 17.sp,
            ),
            const SizedBoxWidget(height: 10),
            TextWidget(
              text: widget.message,
              fontSize: 14.sp,
              color: AppColors.whiteColor,
            ),
            const SizedBoxWidget(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    widget.onNegativeButtonClick();
                    Navigator.pop(context);
                    FocusNode().unfocus();
                  },
                  child: Container(
                    width: 70.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: TextWidget(
                        text: widget.negativeButtonText,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                const SizedBoxWidget(width: 10),
                InkWell(
                  onTap: () {
                    widget.onPositiveButtonClick();
                    Navigator.pop(context);
                    FocusNode().unfocus();
                  },
                  child: Container(
                    width: 100.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: widget.color ?? Colors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: TextWidget(
                        text: widget.positiveButtonText,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
