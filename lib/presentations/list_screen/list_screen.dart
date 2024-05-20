// import 'dart:js';

// ignore_for_file: deprecated_member_use

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/constants/app_images.dart';
import 'package:baapapp/constants/app_strings.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Menulists extends StatelessWidget {
 const  Menulists({Key? key}) : super(key: key);

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              children: [
                _header(),
                const SizedBox(
                  height: 10,
                ),
                _icon(),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 10,
                  color: Color(0xffC9C9C9),
                  thickness: 2,
                  endIndent: 5,
                  indent: 5,
                ),
                const SizedBox(height: 20),
                _menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: AppStrings.theText,
              color: Color(0xff707070),
            ),
            TextWidget(
              text: AppStrings.companyText,
              color: const Color(0xffC9C9C9),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
            const TextWidget(
              text: AppStrings.locationText,
              color: Color(0xff9F9F9F),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: const Color(0XFFC9C9C9).withOpacity(0.3),
          child: TextWidget(
            text: AppStrings.B,
            fontSize: 20.sp,
            color: const Color(0XFF3C3D4A),
          ),
        )
      ],
    );
  }

  _icon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBoxWidget(
          height: 10.h,
        ),
        Row(children: [
          SvgPicture.asset(
            AppImages.homeIcon,
            height: 32.h,
            width: 32.w,
          ),
          const SizedBoxWidget(
            width: 15,
          ),
          SvgPicture.asset(
            AppImages.menuIcon,
            height: 32.h,
            width: 32.w,
          ),
          const SizedBoxWidget(
            width: 15,
          ),
          SvgPicture.asset(
            AppImages.bellIcon,
            height: 32.h,
            width: 32.w,
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        TextWidget(
          text: AppStrings.theText,
          color: const Color(0XFFC8E676),
          fontSize: 25.sp,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  _menu() {
    return Column(children: [
      Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff4A4B57),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '10 Oct 2024 09:00 AM',
                style: TextStyle(
                  color: Color(0xff9F9F9F),
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextWidget(
                text: AppStrings.dron,
                color: const Color(0xffC9C9C9),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff969696),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                  child: const Text(
                      'Open',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff4A4B57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '2 संभाषण',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff4A4B57),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '06 Oct 2024 09:00 AM',
                style: TextStyle(
                  color: Color(0xff9F9F9F),
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWidget(
                    text: AppStrings.medicine,
                    color: const Color(0xffC9C9C9),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 97, 96, 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:  const Text(
                      'यादी पहा',
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff969696),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:  const Text(
                      'Delivered',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff4A4B57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:  const Text(
                      '2 संभाषण',
                      style: TextStyle(color: Color(0xff939393), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff4A4B57),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '06 Oct 2024 09:00 AM',
                style: TextStyle(
                  color: Color(0xff9F9F9F),
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: AppStrings.card,
                    color: const Color(0xffC9C9C9),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:const Color.fromARGB(255, 97, 96, 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:   const Text(
                      'कागदपत्रे',
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 97, 96, 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:  const Text(
                      'Completed',
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff4A4B57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child:  const Text(
                      '2 संभाषण',
                      style: TextStyle(color: Color(0xff939393), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      
    ]);
  }
}
