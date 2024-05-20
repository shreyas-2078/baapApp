import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/constants/app_sizes.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_strings.dart';
import '../../widgets/custom_loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLocation();
    super.initState();
  }

  checkLocation() async {
    var lat = await GetStorage().read('latitude');
    var long = await GetStorage().read('longitude');
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (lat == null && long == null) {
        context.push(Routes.locationAccessScreen);
      } else {
        context.push(Routes.homePageScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Column(
          children: [
            _topContainer(),
            _lastContainer(),
          ],
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

  _topContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.h,
      color: AppColors.backgroundLight,
      child: Center(
        child: TextWidget(
          text: AppStrings.companyText,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  _lastContainer() {
    return Expanded(
      flex: 2,
      child: Container(
        color: AppColors.backgroundDark,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding20px,
            vertical: AppSizes.verticalPadding15px,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomLoadingWidget(context: context),
            ],
          ),
        ),
      ),
    );
  }

  //   ScaffoldWidget(
  //     firstWidget: _firstWidget(),
  //     secondWidget: _secondWidget(),
  //   );
  // }

  // _firstWidget() {
  //   return const Padding(
  //     padding: EdgeInsets.only(top: 55, left: 95, right: 95),
  //     child: TextWidget(
  //       text: AppStrings.companyText,
  //       fontSize: 24,
  //       fontWeight: FontWeight.bold,
  //       color: AppColors.whiteColor,
  //     ),
  //   );
  // }
  // _secondWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const HomePageScreen()));
  //           },
  //           child: SvgPicture.asset(
  //             'assets/images/logo.svg',
  //             width: 60,
  //             height: 60,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         const TextWidget(
  //           text: AppStrings.splashScreenText,
  //           fontSize: 15,
  //           color: AppColors.whiteColor,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
