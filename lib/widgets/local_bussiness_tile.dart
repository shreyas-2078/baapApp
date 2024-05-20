// ignore_for_file: deprecated_member_use

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/models/local_bussiness_response_model/local_bussiness_response_model.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalBussinessListTile extends StatelessWidget {
  const LocalBussinessListTile({
    super.key,
    this.item,
    this.onPressed,
  });

  final LocalBussinessModel? item;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textformFieldColor.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: Image.network(
                item?.icon ?? "",
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBoxWidget(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    color: AppColors.whiteColor,
                    text: item?.name,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  TextWidget(
                    color: const Color(0xffC9C9C9),
                    // generateColorFromHex(item?.theme?.color ?? "909090"),
                    text: item?.desc,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
