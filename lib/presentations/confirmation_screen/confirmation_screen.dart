import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../logic/order/order_confirmaion/order_confirmaion_cubit.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
    this.orderId,
    this.groupId,
  });
  final int? orderId;
  final int? groupId;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    context
        .read<OrderDetailsCubit>()
        .getOrderConfirmation(widget.groupId, widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerWIdget(),
                  _congratsWidget(),
                  SizedBox(height: 15.h),
                  _addressContainerWidget(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: "Made in Paregaon LIVE with ",
                  color: Colors.grey,
                  fontSize: 13.sp,
                ),
                TextWidget(
                  text: "Pride",
                  color: const Color(0XFFE676A4),
                  fontSize: 12.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _headerWIdget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: 'Confirmation',
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.push(Routes.menuScreen, extra: {"index": 1});
          },
          child: Container(
            height: 35.h,
            width: 90.w,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: AppColors.lightGreyColor)),
            child: Center(
              child: TextWidget(
                text: 'ऑर्डर बघा',
                color: Colors.green,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.push(Routes.homePageScreen);
          },
          icon: Icon(
            Icons.home,
            size: 30.sp,
          ),
        ),
      ],
    );
  }

  _congratsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100.h,
          width: 100.w,
          child: Lottie.asset(
            'assets/lottie_json/done.json',
            fit: BoxFit.cover,
          ),
        ),
        TextWidget(
          text: 'अभिनंदन',
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.greenTextColor,
        ),
        SizedBox(
          height: 5.h,
        ),
        TextWidget(
          text: 'तुमची ऑर्डर यशस्वीरित्या टीमकडे पाठवली आहे !',
          fontSize: 18.sp,
        )
      ],
    );
  }

  _addressContainerWidget() {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        if (state is OrderDetailsLoading) {
          return const Center(
            child: CustomCircularProgressIndidator(),
          );
        }
        var addressData = state.orderModel?.deliveryInfo?.shippingAddress;
        DateTime now = DateTime.now();
        DateTime futureDate = now.add(const Duration(days: 5, hours: 2));
        String formattedDate =
            DateFormat('dd MMM, yyyy hh:mm a').format(futureDate);

        return Container(
          width: MediaQuery.of(context).size.width,
          color: AppColors.textGrey.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'ऑर्डर नं : ${widget.orderId}',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextWidget(
                  text: 'अंदाजे ऑर्डर भेटण्याची तारीख',
                  fontSize: 16.sp,
                  color: AppColors.darkGreyColor,
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextWidget(
                  text: formattedDate,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenTextColor,
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextWidget(
                  text: 'ऑर्डर भेटण्याचा पत्ता :',
                  fontSize: 16.sp,
                  color: AppColors.darkGreyColor,
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextWidget(
                  text:
                      "${addressData?.street ?? ''} ${addressData?.locality ?? ''} ${addressData?.city ?? ''} ${addressData?.state ?? ''} ${addressData?.zip ?? ''}",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextWidget(
                  text: 'फोन नं :',
                  fontSize: 16.sp,
                  color: AppColors.darkGreyColor,
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextWidget(
                  text: "${state.orderModel?.userId?.phoneNumber ?? ""}",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/company.png',
                      fit: BoxFit.contain,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
