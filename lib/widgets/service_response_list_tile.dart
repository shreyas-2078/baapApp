import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/models/service_request_detail_model/service_request_detail_model.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceResponseTile extends StatelessWidget {
  const ServiceResponseTile(
      {super.key, this.serviceDetailsModel, this.dateTime});

  final ServiceDetailModel? serviceDetailsModel;
  final String? dateTime;

  @override
  Widget build(BuildContext context) {
    String newStatus = serviceDetailsModel?.newStatus ?? "";
    String oldStatus = serviceDetailsModel?.oldStatus ?? "";

    var formattedNewStatus = formatStatus(newStatus);
    var formattedOldStatus = formatStatus(oldStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        serviceDetailsModel?.oldStatus?.isEmpty != false
            ? TextWidget(
                text: serviceDetailsModel?.customerName ?? '',
                fontSize: 13.sp,
                color: AppColors.textGrey,
              )
            : TextWidget(
                text: serviceDetailsModel?.handledBy ?? '',
                fontSize: 13.sp,
                color: AppColors.textGrey,
              ),
        const SizedBoxWidget(
          height: 2,
        ),
        TextWidget(
          text: dateTime ?? '',
          fontSize: 12.sp,
          color: AppColors.textGrey.withOpacity(0.5),
        ),
        const SizedBoxWidget(
          height: 2,
        ),
        TextWidget(
          text: serviceDetailsModel?.comments.toString() ?? '',
          fontSize: 15.sp,
          color: AppColors.whiteColor,
        ),
        const SizedBoxWidget(
          height: 2,
        ),
        serviceDetailsModel?.oldStatus == serviceDetailsModel?.newStatus
            ? const SizedBox()
            : serviceDetailsModel?.oldStatus?.isEmpty != false
                ? const SizedBox()
                : Row(
                    children: [
                      //change
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  getStatusColor(serviceDetailsModel?.oldStatus)
                                      .withOpacity(0.5),
                              width: 2),
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 3),
                          child: TextWidget(
                            text: formattedOldStatus,
                            color:
                                getStatusColor(serviceDetailsModel?.oldStatus),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                      const SizedBoxWidget(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.textGrey,
                        size: 13.w,
                      ),
                      const SizedBoxWidget(
                        width: 5,
                      ),
                      //change
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  getStatusColor(serviceDetailsModel?.newStatus)
                                      .withOpacity(0.5),
                              width: 2),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 2, bottom: 3),
                          child: TextWidget(
                            text: formattedNewStatus,
                            color:
                                getStatusColor(serviceDetailsModel?.newStatus),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
        const SizedBoxWidget(
          height: 10,
        ),
        const DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 2.0,
          dashLength: 4.0,
          dashColor: Color(0XFF4A4B57),
          dashRadius: 0.0,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
          dashGapRadius: 0.0,
        ),
      ],
    );
  }

  String formatStatus(String backendStatus) {
    switch (backendStatus.toLowerCase()) {
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
        return backendStatus;
    }
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
}
