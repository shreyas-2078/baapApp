import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/payment_service/check_payment/check_payment_cubit.dart';
import 'package:baapapp/main.dart';
import 'package:baapapp/utils/app_utils/app_utils.dart';
import 'package:baapapp/utils/app_utils/snackbar/snackbar.dart';
import 'package:baapapp/widgets/count_timer_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PaymentTimerScreen extends StatefulWidget {
  const PaymentTimerScreen({
    super.key,
    this.id,
    this.groupId,
  });

  final String? id;
  final int? groupId;

  @override
  State<PaymentTimerScreen> createState() => _PaymentTimerScreenState();
}

class _PaymentTimerScreenState extends State<PaymentTimerScreen> {
  bool _willpop = false;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => _willpop,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: systemOverLayStyle,
          surfaceTintColor: Colors.white10,
          iconTheme: const IconThemeData(
            color: AppColors.blackColor,
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            children: <Widget>[
              const Spacer(),
              TextWidget(
                text: 'ही स्क्रीन बंद करू नका.',
                fontSize: 20.sp,
              ),
              const Spacer(),
              CountDownTimer(
                fontSize: 45.sp,
                secondsRemaining: 180,
                letterSpacing: 2,
                whenTimeExpires: () {
                  SnackBarWidget.showSnackbar(
                    context,
                    "पेमेंट झाले नाही.",
                    color: Colors.red,
                  );
                  context.pop(false);
                  setState(() {
                    _willpop = true;
                  });
                },
                whenTimeSeconds: () {
                  context.read<CheckPaymentStatusCubit>().checkPaymentStatus(
                        tranxitionId: widget.id,
                        groupId: apiEndpoints.experienceGroupId,
                      );
                },
              ),
              const Spacer(),
              const Spacer(),
              BlocListener<CheckPaymentStatusCubit, CheckPaymentStatusState>(
                listener: (context, state) {
                  if (state is CheckPaymentStatusSuccess) {
                    SnackBarWidget.showSnackbar(
                        context, "पेमेंट स्वीकारण्यात आले आहे.");
                    context.pop(true);
                    setState(() {
                      _willpop = true;
                    });
                  }
                  if (state is CheckPaymentStatusFailed) {
                    SnackBarWidget.showSnackbar(
                      context,
                      "पेमेंट झाले नाही.",
                      color: Colors.red,
                    );
                    context.pop(false);

                    setState(() {
                      _willpop = true;
                    });
                  }
                  if (state is CheckPaymentStatusError) {}
                },
                child: Container(),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
