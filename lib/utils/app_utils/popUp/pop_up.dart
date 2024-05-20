import 'dart:async';

import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class PopUpWidget {
  static void showPopup(
      BuildContext context, String description, String iconUrl) {
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pop();
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Lottie.asset(iconUrl,
              fit: BoxFit.contain, frameRate: FrameRate(160)),
          content: TextWidget(
              text: description, fontSize: 20.sp, textAlign: TextAlign.center),
        );
      },
    );
  }
}
