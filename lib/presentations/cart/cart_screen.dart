import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/logic/common/dropdown_widget_cubit_address.dart';
import 'package:baapapp/logic/profile_screen/profile_cubit.dart';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:baapapp/utils/app_utils/snackbar/snackbar.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:baapapp/widgets/dropdown_address_widget.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

import '../../widgets/cart_list_tile.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({
    this.groupId,
    this.parentId,
    Key? key,
  }) : super(key: key);

  final int? groupId;
  final int? parentId;

  @override
  State<ShoppingScreen> createState() => _ShoppingState();
}

class _ShoppingState extends State<ShoppingScreen> {
  late AddressElement _addressElement = AddressElement(addressId: 1234);
  @override
  void initState() {
    context.read<CartCubit>().getCart(groupId: widget.groupId);
    context.read<ProfileCubit>().getCustomerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w),
          child: Column(
            children: [
              _titleBarWidget(context),
              const SizedBoxWidget(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartAddSuccess) {
                      context
                          .read<CartCubit>()
                          .getCart(groupId: widget.groupId);
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (contex, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(height: 100.h),
                            ),
                          );
                        },
                      );
                    }
                    if (state is CartLoading) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (contex, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(height: 100.h),
                            ),
                          );
                        },
                      );
                    }
                    if (state.data?.data?.products?.isEmpty ?? false) {
                      return Center(
                          child: TextWidget(
                        text: 'कार्ट रिकामी आहे',
                        fontSize: 18.sp,
                      ));
                    }

                    if (state is CartError) {
                      return Center(
                          child: TextWidget(
                        text: 'कार्ट रिकामी आहे.',
                        fontSize: 18.sp,
                      ));
                    }
                    return ListView.builder(
                      itemCount: state.data?.data?.products?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: CartListTile(
                              cartId: state.data?.data?.cartId,
                              index: index,
                              product: state.data?.data?.products?[index],
                              groupId: widget.groupId),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBoxWidget(height: 10),
              _summaryWidget(context),
              const SizedBoxWidget(height: 10),
              _addressWidget(context),
              const SizedBoxWidget(height: 10),
              _buttonWidget(context),
              const SizedBoxWidget(height: 10),
              _bottomWidget(context),
            ],
          ),
        ),
      ),
    );
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
              text: "Shopping Cart",
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        // Badge.count(
        //   count: 5,
        //   backgroundColor: const Color(0XFF8DE009),
        //   smallSize: 10.h,
        //   largeSize: 20.h,
        //   textColor: Colors.black,
        //   textStyle: TextStyle(fontSize: 13.sp),
        //   child: Icon(Icons.favorite_border, size: 30.h),
        // )
      ],
    );
  }

  Widget _addressWidget(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.customerData?.addresses?.isNotEmpty ?? false) {
          context
              .read<DropdownAddressCubit>()
              .updateSelected(state.customerData?.addresses?.first);
          _addressElement =
              state.customerData?.addresses?.first ?? AddressElement();
          return BlocBuilder<DropdownAddressCubit, AddressElement?>(
            builder: (context, dropState) {
              return Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0XFFBFBCBC).withOpacity(0.3),
                  child: DropDownAddressWidget(
                    context: context,
                    list: state.customerData?.addresses ?? [],
                    selectedValue: dropState ?? _addressElement,
                    onChanged: (AddressElement newValue) {
                      _addressElement = newValue;
                      context
                          .read<DropdownAddressCubit>()
                          .updateSelected(newValue);
                    },
                  ));
            },
          );
        } else {
          return InkWell(
            onTap: () {
              context.push(Routes.profileScreen);
            },
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              color: const Color(0XFFBFBCBC).withOpacity(0.3),
              child: Center(
                child: TextWidget(
                  text: 'तुमचा पत्ता जोडा.',
                  fontSize: 17.sp,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _summaryWidget(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const SizedBox();
        }
        if (state is CartError) {
          return const SizedBox();
        }
        if (state is CartAddSuccess) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // state.data?.data?.saving != null
            //     ? Container(
            //         height: 40.h,
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //           color: AppColors.greenTextColor.withOpacity(0.1),
            //         ),
            //         child: Center(
            //           child: TextWidget(
            //             text:
            //                 'तुम्ही ${state.data?.data?.saving?.inRupeesFormat()} इतकी बचत केली.',
            //             color: AppColors.greenTextColor,
            //             fontSize: 15.sp,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       )
            //     : const SizedBox(),
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: const Color(0xffBFBCBC).withOpacity(0.3),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 10.h, bottom: 15.h, top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Summary',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Divider(
                        color: const Color.fromARGB(255, 102, 102, 102)
                            .withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Subtotal :',
                              fontSize: 15.sp,
                            ),
                            const SizedBoxWidget(height: 5),
                            TextWidget(
                              text: 'Taxes :',
                              fontSize: 15.sp,
                            ),
                            const SizedBoxWidget(height: 5),
                            TextWidget(
                              text: 'Net Pay :',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBoxWidget(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: state.data?.data?.subtotal
                                      ?.inRupeesFormat() ??
                                  0.toString(),
                              fontSize: 15.sp,
                            ),
                            const SizedBoxWidget(height: 5),
                            TextWidget(
                              text:
                                  "${state.data?.data?.taxes?.toInt().inRupeesFormat() ?? 0} ",
                              fontSize: 15.sp,
                            ),
                            const SizedBoxWidget(height: 5),
                            TextWidget(
                              text: state.data?.data?.totalCartPrice
                                      ?.toInt()
                                      .inRupeesFormat() ??
                                  0.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.data?.data?.products?.isEmpty ?? false) {
              SnackBarWidget.showSnackbar(
                context,
                'प्रॉडक्ट जोडा',
                color: Colors.red,
              );
            } else if (_addressElement.addressId == 1234) {
              SnackBarWidget.showSnackbar(
                context,
                'तुमचा पत्ता जोडा',
                color: Colors.red,
              );
            } else {
              context.push(Routes.paymentScreen, extra: {
                'groupId': widget.groupId,
                'cartModel': state.data?.data,
                'addressModel': _addressElement.address
              });
            }
          },
          child: Container(
            height: 50.h,
            color: const Color.fromARGB(255, 215, 214, 214),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextWidget(
                  text: "ऑर्डर करा",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Made in Paregaon LIVE with ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Text(
            "Pride",
            style: TextStyle(color: Color(0XFFE676A4), fontSize: 12),
          )
        ],
      ),
    );
  }
}
