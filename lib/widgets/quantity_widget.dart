// ignore_for_file: must_be_immutable
import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityWidget extends StatefulWidget {
  QuantityWidget({
    Key? key,
    this.quantity = 0,
    this.width = 100,
    required this.onIncrementQuantity,
    required this.onDecrementQuantity,
  }) : super(key: key);
  int quantity;
  final double width;
  final void Function(int) onIncrementQuantity;
  final void Function(int) onDecrementQuantity;
  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => decreaseValue(),
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0XFFDDDDDD),
                ),
                child: Icon(
                  Icons.remove,
                  color: const Color.fromARGB(255, 20, 17, 17),
                  size: 22.h,
                ),
              ),
            ),
            const SizedBoxWidget(width: 10),
            Container(
              height: 35.h,
              width: 45.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textGrey),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: TextWidget(
                text: widget.quantity.toString(),
                fontSize: 17.sp,
              ),
            ),
            const SizedBoxWidget(width: 10),
            InkWell(
              onTap: () => incrementValue(),
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0XFFDDDDDD),
                ),
                child: Icon(
                  Icons.add,
                  color: const Color.fromARGB(255, 20, 17, 17),
                  size: 22.h,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void incrementValue() {
    setState(() {
      widget.quantity++;
    });
    widget.onIncrementQuantity(widget.quantity);
  }

  void decreaseValue() {
    if (widget.quantity > 1) {
      setState(() {
        widget.quantity--;
      });

      widget.onIncrementQuantity(widget.quantity);
    }
  }
}
