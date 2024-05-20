import 'package:baapapp/constants/app_sizes.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/sub_category_response_model/sub_category_response_model.dart';
import '../utils/app_utils/extensions.dart';

class SubCategoryListTile extends StatelessWidget {
  const SubCategoryListTile({
    super.key,
    this.item,
    this.onPressed,
  });

  final SubCategoryModel? item;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: generateColorFromHex(item?.theme?.background ?? "909090"),
          boxShadow: const [
            // BoxShadow(
            //   color: Colors.white,
            //   offset: Offset(-5, -5),
            //   blurRadius: 5,
            //   spreadRadius: -5,
            // ),
          ],
        ),
        padding:
            EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding15px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.network(
            //   item?.icon ?? "",
            //   height: 25.h,
            //   // ignore: deprecated_member_use
            //   color: generateColorFromHex(item?.theme?.color ?? "909090"),
            // ),
            CachedNetworkImage(
              imageUrl: item?.icon ?? "",
              width: 30.w,
              height: 30.h,
            ),
            SizedBoxWidget(
              height: 3.h,
            ),
            TextWidget(
              color: generateColorFromHex(item?.theme?.color ?? "909090"),
              text: item?.name,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.ellipsis,
            ),
            TextWidget(
              color: generateColorFromHex(item?.theme?.color ?? "909090"),
              text: item?.desc,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
