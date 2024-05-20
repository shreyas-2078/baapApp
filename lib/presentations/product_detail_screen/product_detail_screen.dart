import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/product_response_model/product_response_model.dart';
import '../../utils/app_utils/calculate_tax.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, this.item, this.groupId});

  final ProductList? item;
  final int? groupId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.productScreenBackground.withOpacity(1.0),
      // appBar: AppBar(
      //   systemOverlayStyle: systemOverLayStyle,
      //   surfaceTintColor: Colors.white10,
      //   backgroundColor: AppColors.productScreenBackground.withOpacity(1.0),
      //   iconTheme: const IconThemeData(
      //     color: AppColors.blackColor,
      //   ),
      //   automaticallyImplyLeading: true,
      //   elevation: 0,
      //   title: TextWidget(
      //     text: widget.item?.name.toString().capitalize(),
      //     color: AppColors.blackColor,
      //     fontSize: 17.sp,
      //   ),
      //   toolbarHeight: 50,
      // ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddSuccess) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    content: SizedBoxWidget(
                      height: 230.h,
                      width: 230.w,
                      child: Column(
                        children: [
                          Lottie.asset('assets/lottie_json/add_cart.json',
                              fit: BoxFit.cover, height: 220.h, width: 220.w),
                          SizedBox(
                            height: 5.h,
                          ),
                          TextWidget(
                            text: 'तुमची वस्तू कार्ट मध्ये जोडली आहे ',
                            color: const Color.fromARGB(255, 40, 110, 42),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  );
                });
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
              context.push(Routes.shoppingScreen, extra: {
                "groupId": widget.groupId,
                "parentId": widget.item?.parentId,
              });
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _titleBarWidget(context),
                  SizedBox(height: 20.h),
                  _imageWidget(),
                  SizedBox(height: 20.h),
                  _productDetailWidget(),
                ],
              ),
              const Spacer(),
              _buttonWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _titleBarWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.keyboard_backspace, size: 25.h),
            ),
            const SizedBoxWidget(width: 5),
            TextWidget(
              text: "Product Detail Screen",
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }

  _imageWidget() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: false,
            reverse: false,
            scrollPhysics: const BouncingScrollPhysics(),
            aspectRatio: 16 / 9,
            animateToClosest: true,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.item?.pictures?.map((picture) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                        picture.toString(),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList() ??
              [],
        ),
        SizedBox(height: 10.h),
        roundedIndicator(
          count: widget.item?.pictures?.length ?? 0,
          index: currentIndex,
          color: Colors.grey,
          activeColor: Colors.black,
          space: 8.0,
        ),
      ],
    );
  }

  Container roundedIndicator({
    required int count,
    required int index,
    required Color color,
    required Color activeColor,
    required double space,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: space),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          return Container(
            width: 10.w,
            height: 10.h,
            margin: EdgeInsets.symmetric(horizontal: space),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == index ? activeColor : color,
            ),
          );
        }),
      ),
    );
  }

  _productDetailWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 320.h,
      decoration: BoxDecoration(
        color: AppColors.productScreenBackground.withOpacity(1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: widget.item?.name ?? "",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 2.h,
              ),
              TextWidget(
                text: widget.item?.category ?? "",
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  TextWidget(
                    text: Calculations.getPriceWithTotalTax(item: widget.item).toInt().inRupeesFormat(),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  TextWidget(
                    text:  Calculations.getPriceWithMarketPrice(item: widget.item).toInt().inRupeesFormat(),
                    fontSize: 16.sp,
                    color: const Color(0XFFB7B7B7),
                    textDecoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Html(
                data: widget.item?.value?.description,
                style: {
                  "body": Style(
                    fontSize: FontSize(
                      16.sp,
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buttonWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomButton(
        buttonTextSize: 14.sp,
        borderRadius: 20,
        height: 38.h,
        buttonText: 'खरेदी करा',
        fontWeight: true,
        textColor: Colors.green,
        color: Colors.white,
        onPress: () {
          context.read<CartCubit>().addToCart(
                widget.item?.productcode,
                widget.groupId,
                widget.item?.parentId,
              );
        },
      ),
    );
  }
}
