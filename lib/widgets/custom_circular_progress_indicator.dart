import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndidator extends StatefulWidget {
  const CustomCircularProgressIndidator({super.key});

  @override
  State<CustomCircularProgressIndidator> createState() =>
      _CustomCircularProgressIndidatorState();
}

class _CustomCircularProgressIndidatorState
    extends State<CustomCircularProgressIndidator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.w,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.black26,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
      ),
    );
  }
}
