import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/text_widget.dart';

class SnackBarWidget {
  static void showSnackbar(BuildContext context, String errorMessage,
      {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color ?? Colors.green,
        content: TextWidget(
          text: errorMessage,
          fontSize: 15.sp,
        )));
  }
}
