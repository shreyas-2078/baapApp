import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/constants/app_images.dart';
import 'package:baapapp/constants/app_strings.dart';
import 'package:baapapp/logic/location_screen/location_cubit.dart';
import 'package:baapapp/utils/app_utils/snackbar/snackbar.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/open_confirmation_dialog.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        extendBody: true,
        body: BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationStateDenied) {
              SnackBarWidget.showSnackbar(context, state.message ?? '');
            }
            if (state is LocationPremited) {
              context.read<LocationCubit>().saveLocation();
              context.push(Routes.homePageScreen);
            }
            if (state is LocationStateSkiped) {
              openConfirmationDialog(
                context: context,
                title: 'लोकेशन परवानगी',
                message:
                    'तुम्ही लोकेशन ची परवानगी नाकारली आहे हे तुम्हाला मान्य आहे का ?',
                color: Colors.red,
                positiveButtonText: 'हो',
                negativeButtonText: 'नाही',
                onPositiveButtonClick: () {
                  context.push(Routes.homePageScreen);
                },
                onNegativeButtonClick: () {},
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: "तुमचे लोकेशन काय आहे ?",
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                  color: const Color(0XFFC8E676),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextWidget(
                  text:
                      "उपलब्ध सेवा आणि दुकाने दर्शविण्यासाठी आम्हाला तुमचे लोकेशन आवश्यक आहे.",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                // const Spacer(),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: Image.asset(AppImages.locationPng, height: 200.h)),
                SizedBox(
                  height: 10.h,
                ),
                TextWidget(
                    text: 'Disclaimer -',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.whiteColor),
                SizedBox(
                  height: 5.h,
                ),
                _disclaimerWidget(),
                // const Spacer(),

                const Spacer(),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        height: 47.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.lightGreyColor.withOpacity(0.3),
                        buttonText: 'तुमच्या लोकेशन ची परवानगी द्या',
                        buttonTextSize: 15.sp,
                        inProgress: state is LocationStateGranted,
                        textColor: AppColors.whiteColor.withOpacity(0.8),
                        fontWeight: true,
                        onPress: () {
                          context.read<LocationCubit>().checkGps(context);
                        },
                        // color: MaterialStatePropertyAll.,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      context.read<LocationCubit>().skipButtonPressed();
                    },
                    child: TextWidget(
                      text: 'Skip',
                      fontSize: 15.sp,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                ),
                // CustomButton(
                //   height: 44.h,
                //   width: MediaQuery.of(context).size.width,
                //   color: AppColors.backgroundDark,
                //   buttonText: 'Skip',
                //   buttonTextSize: 15.sp,
                //   textColor: AppColors.whiteColor.withOpacity(0.8),
                //   fontWeight: true,
                //   onPress: () {
                //     context.read<LocationCubit>().skipButtonPressed();
                //     // context.push(Routes.homePageScreen);
                //   },
                //   // color: MaterialStatePropertyAll.,
                // ),
                SizedBox(
                  height: 30.h,
                )

                // _lastContainer(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(15),
          color: AppColors.backgroundDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                text: AppStrings.madeText,
                color: Colors.grey,
                fontSize: 13.sp,
              ),
              TextWidget(
                text: AppStrings.prideText,
                color: const Color(0XFFE676A4),
                fontSize: 12.sp,
              )
            ],
          ),
        ),
      ),
    );
  }

  _disclaimerWidget() {
    return SizedBox(
      height: 210.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                text:
                    '1. App is using location information for showing you better community experience.',
                fontSize: 13.sp,
                color: AppColors.textColor),
            TextWidget(
                text:
                    '2. We do not represent any government entity, any information related to government schemes is taken from from this websites ',
                fontSize: 13.sp,
                color: AppColors.textColor),
            TextWidget(
                text: 'https://mahadbt.maharashtra.gov.in/ ',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor),
            TextWidget(
                text:
                    '3. The personal information captured in your profile section is encrypted in transit and stored in secured database.',
                fontSize: 13.sp,
                color: AppColors.textColor),
          ],
        ),
      ),
    );
  }
}
