import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/common/radio/radio__button_cubit.dart';
import 'package:baapapp/logic/group_data/group_data_cubit.dart';
import 'package:baapapp/logic/order/place_order/place_order_cubit.dart';
import 'package:baapapp/logic/payment_service/check_vpa/check_vpa_cubit.dart';
import 'package:baapapp/logic/payment_service/collect_vpa/collect_vpa_cubit.dart';
import 'package:baapapp/logic/payment_service/get_upi_list/get_upi_list_cubit.dart';
import 'package:baapapp/main.dart';
import 'package:baapapp/models/cart_model/get_cart_response_model.dart';
import 'package:baapapp/models/group_response_model/group_response_model.dart';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:baapapp/utils/app_utils/app_utils.dart';
import 'package:baapapp/utils/app_utils/snackbar/snackbar.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/event_textformfield_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:skeletons/skeletons.dart';
import '../../logic/profile_screen/profile_cubit.dart';
import '../../widgets/sizedbox_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    this.groupId,
    this.cartModel,
    this.addressModel,
    super.key,
  });

  final int? groupId;
  final CartModel? cartModel;
  final AddressModel? addressModel;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _paymentMode = 'Cash on Delivery';

  final TextEditingController _upiController = TextEditingController();
  final _upiKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GetUPIListCubit>().getUpiList(groupId: widget.groupId);
    context.read<GroupDataCubit>().getGroupData(groupId: widget.groupId);
    context.read<CheckVPACubit>().changeState();
    context.read<RadioButtonCubit>().selectUpiId('');
    super.initState();
  }

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: systemOverLayStyle,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        title: TextWidget(
          text: 'Payment Options',
          color: Colors.black,
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlocListener<PlaceOrderCubit, PlaceOrderState>(
            listener: (context, state) {
              if (state is PlaceOrderError) {
                SnackBarWidget.showSnackbar(
                  context,
                  'ऑर्डर प्रोसेस झाली नाही, तुम्ही आमच्या कस्टमर सोबत संवाद साधू शकता.',
                  color: Colors.red,
                );
              }
              if (state is PlaceOrderLoaded) {
                context.read<RadioButtonCubit>().selectUpiId('');
                context.push(Routes.confirmationScreen, extra: {
                  "orderId": state.placeOrderModel?.orderId,
                  "groupId": widget.groupId,
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
              child: SingleChildScrollView(
                child: BlocBuilder<GroupDataCubit, GroupDataState>(
                  builder: (context, state) {
                    var groupData = state.groupData?.commonSettings;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          _addressWidget(context),
                          const SizedBoxWidget(height: 10),
                          _summaryWidget(context),
                          const SizedBoxWidget(height: 10),
                          _paymenMethodWiget(context, groupData),
                          _paymentMode == 'Pay using UPI'
                              ? _checkVPAWidgt(context)
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return BlocBuilder<RadioButtonCubit, RadioButtonState>(
                builder: (context, radioState) {
                  return BlocListener<CollectVPACubit, CollectVPAState>(
                    listener: (context, s) {
                      if (s is CollectVPASuccess) {
                        context.push(Routes.paymentTimerScreen, extra: {
                          "id": s.collectVpaModel?.id,
                          'groupId': apiEndpoints.experienceGroupId,
                        }).then((data) {
                          if (data == true) {
                            var address = widget.addressModel;
                            var cart = widget.cartModel;
                            List<Map<String, dynamic>?> orderDetails = [];
                            cart?.products?.forEach((a) {
                              orderDetails.add({
                                "quantity": a.quantity,
                                "totalProductPrice": a.totalProductPrice,
                                "product": a.productcode,
                              });
                            });
                            context.read<PlaceOrderCubit>().saveOrder(
                                  context,
                                  groupId: widget.groupId,
                                  cartId: cart?.cartId,
                                  paymentUPI: radioState.selectedUpiId,
                                  paymentMode: _paymentMode,
                                  totalCartPrice: cart?.totalCartPrice,
                                  totalProductQuantity:
                                      cart?.totalProductQuantity,
                                  subtotal: cart?.subtotal,
                                  saving: cart?.saving,
                                  taxes: cart?.taxes,
                                  userName: state.customerData?.name,
                                  userId: state.customerData?.userId,
                                  orderDetails: orderDetails,
                                  streetAddress: address?.street,
                                  locality: address?.locality,
                                  city: address?.city,
                                  state: address?.state,
                                  zip: address?.zip,
                                  currency: "Rs",
                                  paymentStatus: "paid",
                                  transactionDate:
                                      s.collectVpaModel?.transactionDate,
                                  txnId: s.collectVpaModel?.txnId,
                                );
                          }
                        });
                      }
                    },
                    child: const SizedBoxWidget(),
                  );
                },
              );
            },
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<RadioButtonCubit, RadioButtonState>(
              builder: (context, state) {
                return _paymentMode == 'Pay using UPI' &&
                        state.selectedUpiId != ''
                    ? InkWell(
                        onTap: () {
                          context.read<CollectVPACubit>().collectVpa(
                                amount: widget.cartModel?.totalCartPrice,
                                message: "Making Payment",
                                vpaId: state.selectedUpiId,
                                groupId: apiEndpoints.experienceGroupId,
                              );
                        },
                        child: Container(
                          height: 50.h,
                          color: const Color.fromARGB(255, 215, 214, 214),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: context.watch<PlaceOrderCubit>().state
                                      is PlaceOrderLoading
                                  ? const CustomCircularProgressIndidator()
                                  : TextWidget(
                                      text: "पेमेंट करा",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
            _paymentMode == 'Cash on Delivery'
                ? BlocBuilder<RadioButtonCubit, RadioButtonState>(
                    builder: (context, radioState) {
                      return BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              var address = widget.addressModel;
                              var cart = widget.cartModel;
                              List<Map<String, dynamic>?> orderDetails = [];
                              cart?.products?.forEach((a) {
                                orderDetails.add({
                                  "quantity": a.quantity,
                                  "totalProductPrice": a.totalProductPrice,
                                  "product": a.productcode,
                                });
                              });
                              context.read<PlaceOrderCubit>().saveOrder(
                                    context,
                                    groupId: widget.groupId,
                                    cartId: cart?.cartId,
                                    paymentMode: _paymentMode,
                                    totalCartPrice: cart?.totalCartPrice,
                                    totalProductQuantity:
                                        cart?.totalProductQuantity,
                                    subtotal: cart?.subtotal,
                                    saving: cart?.saving,
                                    taxes: cart?.taxes,
                                    paymentUPI: radioState.selectedUpiId,
                                    userName: state.customerData?.name,
                                    userId: state.customerData?.userId,
                                    orderDetails: orderDetails,
                                    streetAddress: address?.street,
                                    locality: address?.locality,
                                    city: address?.city,
                                    state: address?.state,
                                    zip: address?.zip,
                                    currency: "Rs",
                                    paymentStatus: "unpaid",
                                  );
                            },
                            child: Container(
                              height: 50.h,
                              color: const Color.fromARGB(255, 215, 214, 214),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: context.watch<PlaceOrderCubit>().state
                                          is PlaceOrderLoading
                                      ? const CustomCircularProgressIndidator()
                                      : TextWidget(
                                          text: "ऑर्डर करा",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const SizedBox(),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 10),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressWidget(BuildContext context) {
    return Container(
      height: 50.h,
      width: MediaQuery.of(context).size.width,
      color: const Color(0XFFBFBCBC).withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TextWidget(
              text: 'Delivering to - ',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            TextWidget(
              text: "${widget.addressModel?.tag} : ",
              color: Colors.red,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            Expanded(
              child: TextWidget(
                text:
                    "${widget.addressModel?.street ?? ''} ${widget.addressModel?.locality ?? ''} ${widget.addressModel?.city ?? ''} ${widget.addressModel?.state ?? ''} ${widget.addressModel?.zip ?? ''}",
                textOverflow: TextOverflow.ellipsis,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryWidget(BuildContext context) {
    return Column(
      children: [
        // widget.cartModel?.saving != null
        //     ? Container(
        //         height: 40.h,
        //         width: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //           color: AppColors.greenTextColor.withOpacity(0.1),
        //         ),
        //         child: Center(
        //           child: TextWidget(
        //             text:
        //                 'तुम्ही ${widget.cartModel?.saving?.inRupeesFormat()} इतकी बचत केली.',
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
                  padding:
                      const EdgeInsets.only(top: 5.0, right: 10, bottom: 10),
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
                          text: 'Subtotal',
                          fontSize: 15.sp,
                        ),
                        const SizedBoxWidget(height: 5),
                        TextWidget(
                          text: 'Taxes',
                          fontSize: 15.sp,
                        ),
                        const SizedBoxWidget(height: 5),
                        TextWidget(
                          text: 'Net Pay',
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
                          text: widget.cartModel?.subtotal?.inRupeesFormat() ??
                              0.toString(),
                          fontSize: 15.sp,
                        ),
                        const SizedBoxWidget(height: 5),
                        TextWidget(
                          text:
                              "${widget.cartModel?.taxes?.toInt().inRupeesFormat() ?? 0}",
                          fontSize: 15.sp,
                        ),
                        const SizedBoxWidget(height: 5),
                        TextWidget(
                          text: widget.cartModel?.totalCartPrice
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
  }

  Widget _paymenMethodWiget(BuildContext context, CommonSettings? groupData) {
    return BlocBuilder<GroupDataCubit, GroupDataState>(
      builder: (context, state) {
        if (state is GroupDataLoading) {
          return Column(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: MediaQuery.of(context).size.width,
                  height: 120.h,
                ),
              ),
            ],
          );
        }
        return Container(
          color: const Color(0xffBFBCBC).withOpacity(0.3),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Payment Method',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 10.w, bottom: 10.h),
                  child: Divider(
                    color: const Color.fromARGB(255, 102, 102, 102)
                        .withOpacity(0.5),
                    thickness: 1,
                  ),
                ),
                groupData?.isPaymentOffline ?? false
                    ? RadioListTile<String?>(
                        title: TextWidget(
                          text: 'Cash on Delivery',
                          fontSize: 15.sp,
                        ),
                        value: 'Cash on Delivery',
                        activeColor: Colors.black,
                        groupValue: _paymentMode,
                        onChanged: (String? value) {
                          setState(() {
                            _paymentMode = value;
                          });
                        },
                      )
                    : const SizedBox(),
                groupData?.isPaymentOnine ?? false
                    ? RadioListTile<String?>(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Pay using UPI',
                              fontSize: 15.sp,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 18.sp,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _addUPIBottomModelSheet(context);
                              },
                            )
                          ],
                        ),
                        value: 'Pay using UPI',
                        activeColor: Colors.black,
                        groupValue: _paymentMode,
                        onChanged: (String? value) {
                          setState(() {
                            _paymentMode = value;
                          });
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _checkVPAWidgt(BuildContext context) {
    return Container(
      color: const Color(0xffBFBCBC).withOpacity(0.3),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Divider(
                color:
                    const Color.fromARGB(255, 102, 102, 102).withOpacity(0.5),
                thickness: 1,
              ),
            ),
            BlocBuilder<GetUPIListCubit, GetUPIListState>(
              builder: (context, state) {
                if (state.getUPIListModel?.data?.isEmpty ?? false) {
                  context.read<RadioButtonCubit>().selectUpiId('');
                  return InkWell(
                    onTap: () {
                      _addUPIBottomModelSheet(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: TextWidget(
                        text: "UPI ID जोडा",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.getUPIListModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return BlocBuilder<RadioButtonCubit, RadioButtonState>(
                        builder: (context, radioState) {
                          return Column(
                            children: [
                              RadioListTile<String>(
                                title: TextWidget(
                                  text: state.getUPIListModel?.data?[index].upi,
                                  fontSize: 15.sp,
                                ),
                                value:
                                    state.getUPIListModel?.data?[index].upi ??
                                        '',
                                activeColor: Colors.deepPurpleAccent,
                                groupValue: radioState.selectedUpiId,
                                onChanged: (String? value) {
                                  context
                                      .read<RadioButtonCubit>()
                                      .selectUpiId(value ?? '');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addUPIBottomModelSheet(BuildContext context) {
    context.read<CheckVPACubit>().changeState();
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.r),
          topRight: Radius.circular(22.r),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: BlocListener<GetUPIListCubit, GetUPIListState>(
            listener: (context, state) {
              if (state is GetUPIListError) {
                SnackBarWidget.showSnackbar(
                  context,
                  state.error ?? '',
                  color: Colors.red,
                );
              }
            },
            child: BlocBuilder<CheckVPACubit, CheckVPAState>(
              builder: (context, state) {
                if (state is CheckVPAError) {
                  Future.delayed(const Duration(seconds: 2), () {
                    context.read<CheckVPACubit>().changeState();
                  });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'तुमचा पेमेंट UPI जोडा',
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBoxWidget(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'UPI Id चुकला आहे.',
                            fontSize: 17.sp,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBoxWidget(height: 30),
                    ],
                  );
                }
                if (state is CheckVPASuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            text: 'तुमचा पेमेंट UPI जोडा',
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          TextWidget(
                            text: '  (Verified)',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBoxWidget(height: 20),
                      EventTextformFieldWidget(
                        hintText: "xyz123@bank",
                        fontSize: 17.sp,
                        controller: _upiController,
                        formFieldKey: _upiKey,
                        readOnly: true,
                        hintTextColor: Colors.white.withOpacity(0.3),
                        backgroundColor:
                            AppColors.editTextformFieldColor.withOpacity(0.5),
                      ),
                      const SizedBoxWidget(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomOutlinedButton(
                            buttonHeight: 35.h,
                            borderradius: 32.r,
                            buttonWidth: 100.w,
                            textSize: 16.sp,
                            buttonText: 'Add',
                            textColor: Colors.white,
                            backgroundColor: Colors.green,
                            onPressed: () {
                              context.read<GetUPIListCubit>().updateUPI(
                                    context,
                                    _upiController.text.trim(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'तुमचा पेमेंट UPI जोडा',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBoxWidget(height: 20),
                    EventTextformFieldWidget(
                      hintText: "xyz123@bank",
                      fontSize: 17.sp,
                      onOutSideTap: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _upiController,
                      formFieldKey: _upiKey,
                      validator: (value) {
                        if (!(value?.validateUPI() ?? false)) {
                          return 'UPI ID चुकीचा आहे.';
                        }
                        if (value!.length > 1 && value != "") {
                          return null;
                        }
                        return "UPI ID टाकणे गरजेचे आहे.";
                      },
                      hintTextColor: Colors.white.withOpacity(0.3),
                      backgroundColor:
                          AppColors.editTextformFieldColor.withOpacity(0.5),
                    ),
                    const SizedBoxWidget(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_upiKey.currentState?.validate() != null) {
                              context
                                  .read<CheckVPACubit>()
                                  .checkVpa(vpaId: _upiController.text.trim());
                            }
                          },
                          child: Container(
                            height: 35.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: state is CheckVPASuccess
                                    ? Colors.green
                                    : const Color(0XFF4A4B57),
                                borderRadius: BorderRadius.circular(32)),
                            child: state is CheckVPALoading
                                ? const Center(
                                    child: CustomCircularProgressIndidator(),
                                  )
                                : (state is CheckVPASuccess
                                    ? Center(
                                        child: TextWidget(
                                            text: 'Verified',
                                            fontSize: 16.sp,
                                            color: const Color(0XFFA8A8A8)),
                                      )
                                    : Center(
                                        child: TextWidget(
                                            text: 'Verify',
                                            fontSize: 16.sp,
                                            color: const Color(0XFFA8A8A8)),
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    ).whenComplete(() {
      _upiController.clear();
    });
  }
}
