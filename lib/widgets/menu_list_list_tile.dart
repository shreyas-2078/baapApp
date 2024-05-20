import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/menu_logic/menu_cubit.dart';
import 'package:baapapp/widgets/open_confirmation_dialog.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/service_request_response_model/service_request_response_model.dart';

class MenuListTile extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MenuListTile({super.key, this.menuModel, this.dateTime});

  final MenuModel? menuModel;
  final String? dateTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
        builder: (context, state) {
      var responseCount = menuModel?.serviceResponsesCount ?? 0;
      var serviceRequestId = menuModel?.servicerequestId ?? 0;

      return Slidable(
        endActionPane: ActionPane(
            extentRatio: 0.6,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: false,
                onPressed: (context) {
                  openConfirmationDialog(
                    scaffoldKey: _scaffoldKey,
                    context: context,
                    title: 'संग्रहित करा',
                    color: Colors.red,
                    message:
                        'तुम्हाला तुमची ऑर्डर पुन्हा संग्रहित करायची आहे का?',
                    positiveButtonText: "हो",
                    negativeButtonText: "नाही",
                    onPositiveButtonClick: () {
                      context
                          .read<ServiceRequestCubit>()
                          .archiveServiceRequests(serviceRequestId);
                    },
                    onNegativeButtonClick: () {},
                  );
                },
                backgroundColor: const Color(0xFFAEEA00),
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: 'Archive',
              ),
              SlidableAction(
                autoClose: false,
                onPressed: (context) {
                  openConfirmationDialog(
                    scaffoldKey: _scaffoldKey,
                    context: context,
                    title: 'रद्द करा',
                    color: Colors.red,
                    message: 'तुम्हाला तुमची ऑर्डर खरोखर रद्द करायची आहे का?',
                    positiveButtonText: "हो",
                    negativeButtonText: "नाही",
                    onPositiveButtonClick: () {
                      context
                          .read<ServiceRequestCubit>()
                          .cancelServiceRequests(serviceRequestId);
                    },
                    onNegativeButtonClick: () {},
                  );
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.close,
                label: 'Cancel',
              ),
            ]),
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.darkGreyColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 9.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: (dateTime ?? '').isEmpty ? '------' : dateTime,
                  color: AppColors.menuGreyColor,
                  fontSize: 13.sp,
                ),
                const SizedBoxWidget(
                  height: 10,
                ),
                SizedBox(
                  width: 300.w,
                  child: TextWidget(
                    text: (menuModel?.title ?? '').isEmpty
                        ? '--------'
                        : menuModel?.title,
                    color: Colors.white,
                    fontSize: 17.sp,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBoxWidget(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                        top: 5.h,
                        bottom: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkGreyColor..withOpacity(0.5),
                        border: Border.all(
                            color: getStatusColor(menuModel?.status)
                                .withOpacity(0.5),
                            width: 2),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: TextWidget(
                        text: (menuModel?.status.toString() ?? '').isEmpty
                            ? '------'
                            : getStatusName(menuModel?.status),
                        color: getStatusColor(menuModel?.status),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBoxWidget(
                      width: 15,
                    ),
                    state.menuModel?.first.serviceResponsesCount != null
                        ? Row(
                            children: [
                              TextWidget(
                                text: 'संभाषण',
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              TextWidget(
                                text: ' ($responseCount)',
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case 'new':
        return AppColors.newColor;
      case 'inprogress':
        return AppColors.inprogressColor;
      case 'open':
        return AppColors.openColor;
      case 'completed':
        return AppColors.completedColor;
      case 'rejected':
        return AppColors.rejectColor;
      case 'close':
        return Colors.tealAccent;
      case 'blocked':
        return Colors.red;
      default:
        return AppColors.lightGreyColor;
    }
  }

  String? getStatusName(String? status) {
    switch (status) {
      case 'new':
        return 'New';
      case 'inprogress':
        return 'In Progress';
      case 'open':
        return 'Open';
      case 'completed':
        return 'Completed';
      case 'rejected':
        return 'Rejected';
      case 'close':
        return 'Close';
      case 'blocked':
        return 'Blocked';
      default:
        return '';
    }
  }
}
