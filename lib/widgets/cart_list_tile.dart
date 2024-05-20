import 'package:baapapp/constants/app_images.dart';
import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/widgets/open_confirmation_dialog.dart';
import 'package:baapapp/widgets/quantity_widget.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../models/cart_model/get_cart_response_model.dart';

class CartListTile extends StatefulWidget {
  const CartListTile({
    super.key,
    this.product,
    this.groupId,
    this.cartId,
    required this.index,
  });

  final Product? product;
  final int? cartId;
  final int index;
  final int? groupId;

  @override
  State<CartListTile> createState() => _CartListTileState();
}

class _CartListTileState extends State<CartListTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          color: const Color(0XFFBFBCBC).withOpacity(0.2),
          height: 130.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: SizedBox(
                  height: 155.h,
                  width: 120.w,
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.product?.productcode?.pictures?.first ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBoxWidget(width: 10),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150.w,
                              child: TextWidget(
                                text: widget.product?.productcode?.name,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBoxWidget(width: 20),
                            InkWell(
                              onTap: () {
                                openConfirmationDialog(
                                  context: context,
                                  title: 'काढून टाका',
                                  message:
                                      'तुम्हाला हा प्रॉडक्ट काढून टाकायचा आहे का?',
                                  color: Colors.red,
                                  negativeButtonText: 'नाही',
                                  positiveButtonText: 'हो',
                                  onNegativeButtonClick: () {},
                                  onPositiveButtonClick: () {
                                    context
                                        .read<CartCubit>()
                                        .deleteCartProductById(
                                          productId: widget.product?.productcode
                                              ?.productcode,
                                          cartId: widget.cartId,
                                          groupId: widget.groupId,
                                        );
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                AppImages.deleteIcon,
                                height: 20.h,
                              ),
                            ),
                          ],
                        ),
                        const SizedBoxWidget(height: 5),
                        SizedBox(
                          width: 200.w,
                          child: TextWidget(
                            text:
                                "${widget.product?.quantity} X ${widget.product?.productcode?.regularPrice?.inRupeesFormat() ?? 0} = ${widget.product?.totalProductPrice?.inRupeesFormat() ?? 0}",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    QuantityWidget(
                      quantity: widget.product?.quantity ?? 0,
                      onIncrementQuantity: (value) {
                        state.data?.data?.products?[widget.index].quantity =
                            value;
                        context.read<CartCubit>().updateCartProductById(
                              widget.groupId,
                              state.data?.data?.products?[widget.index]
                                  .productcode?.productcode,
                              state
                                  .data?.data?.products?[widget.index].quantity,
                            );
                      },
                      onDecrementQuantity: (value) {
                        state.data?.data?.products?[widget.index].quantity =
                            value;
                        context.read<CartCubit>().updateCartProductById(
                              widget.groupId,
                              state.data?.data?.products?[widget.index]
                                  .productcode?.productcode,
                              state
                                  .data?.data?.products?[widget.index].quantity,
                            );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
