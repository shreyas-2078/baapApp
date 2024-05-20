import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/models/product_response_model/product_response_model.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_utils/calculate_tax.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.productModel,
    this.productId,
    this.groupId,
    this.subGroupId,
  }) : super(key: key);

  final ProductList? productModel;
  final int? productId;
  final int? groupId;
  final int? subGroupId;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withOpacity(0.7),
      ),
      height: 300.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            widget.productModel?.pictures?.first.toString() ?? "",
            height: 110.h,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  textOverflow: TextOverflow.ellipsis,
                  text: widget.productModel?.name ?? '',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 50.w,
                        child: TextWidget(
                          text: Calculations.getPriceWithTotalTax(item: widget.productModel).toInt().inRupeesFormat(),
                          fontSize: 12.sp,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 50.w,
                        child: TextWidget(
                          text: Calculations.getPriceWithMarketPrice(item: widget.productModel).toInt().inRupeesFormat(),
                          fontSize: 12.sp,
                          textOverflow: TextOverflow.ellipsis,
                          textDecoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<CartCubit>().addToCart(
                              widget.productId,
                              widget.groupId,
                              widget.subGroupId,
                            );
                        showDialog(
                            context: context,
                            barrierDismissible: false,
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
                                      Lottie.asset(
                                          'assets/lottie_json/add_cart.json',
                                          fit: BoxFit.cover,
                                          height: 220.h,
                                          width: 220.w),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      TextWidget(
                                        text:
                                            'तुमची वस्तू कार्टमध्ये जोडली आहे ',
                                        color: const Color.fromARGB(
                                            255, 40, 110, 42),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        height: 32.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(color: AppColors.lightGreyColor)),
                        child: Center(
                          child: TextWidget(
                            text: 'खरेदी करा ',
                            color: Colors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     isFavorite
                    //         ? Icons.favorite
                    //         : Icons.favorite_border_outlined,
                    //     color: isFavorite ? Colors.red : null,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       isFavorite = !isFavorite;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
