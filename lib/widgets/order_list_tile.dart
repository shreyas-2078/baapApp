import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/models/order_list/order_list_response_model.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    super.key,
    this.orderData,
    this.formattedDateTime,
  });

  final OrderData? orderData;
  final String? formattedDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.darkGreyColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              TextWidget(
                text: "Order No:",
                fontSize: 14.sp,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: 5.w,
              ),
              TextWidget(
                text: orderData?.orderId.toString() ?? "",
                fontSize: 14.sp,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          TextWidget(
            text: 'Approximate Delivery Date',
            fontSize: 15.sp,
            color: AppColors.lightGreyColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5.h,
          ),
          TextWidget(
            text: formattedDateTime ?? "",
            fontSize: 15.sp,
            color: AppColors.greenTextColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 7.h,
          ),
          CustomButton(
            height: 37.h,
            width: 124.w,
            color: AppColors.lightGreyColor.withOpacity(0.4),
            buttonText: 'Track Order',
            textColor: AppColors.whiteColor,
            fontWeight: true,
            onPress: () {
              context.push(Routes.orderDetailScreen, extra: {
                "orderId": orderData?.orderId,
                "formattedDateTime": formattedDateTime,
              });
            },
            // color: MaterialStatePropertyAll.,
          ),
        ]),
      ),
    );
  }
}
