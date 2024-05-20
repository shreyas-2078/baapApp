// import 'package:baapapp/constants/app_colors.dart';
// import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
// import 'package:baapapp/widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DropDownAddressWidget extends StatelessWidget {
//   const DropDownAddressWidget({
//     Key? key,
//     required this.context,
//     required this.list,
//     required this.selectedValue,
//     required this.onChanged,
//     this.readOnly = false,
//     this.isRounded = true,
//   }) : super(key: key);

//   final BuildContext context;
//   final List<AddressElement> list;
//   final AddressElement? selectedValue;
//   final Function onChanged;
//   final bool readOnly;
//   final bool isRounded;

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xffBFBCBC).withOpacity(0.3),
//         borderRadius: isRounded ? BorderRadius.circular(12) : null,
//       ),
//       padding: EdgeInsets.only(top: 8.h, bottom: 10.h, left: 10.w),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<AddressElement>(
//           value: selectedValue,
//           isExpanded: true,
//           isDense: true,
//           dropdownColor: AppColors.whiteColor,
//           icon: Padding(
//             padding: EdgeInsets.only(
//               right: 11.w,
//             ),
//             child: Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//               size: 24.h,
//             ),
//           ),
//           items: list.map((AddressElement? value) {
//             return DropdownMenuItem(
//               value: value,
//               child: Row(
//                 children: [
//                   TextWidget(
//                     text: "${value?.address?.tag} - ",
//                     color: Colors.red,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   Expanded(
//                     child: TextWidget(
//                       text:
//                           "${value?.address?.street} ${value?.address?.locality} ${value?.address?.city} ${value?.address?.state} ${value?.address?.zip}",
//                       textOverflow: TextOverflow.ellipsis,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//           selectedItemBuilder: (BuildContext context) {
//             return list.map<Widget>(
//               (AddressElement? value) {
//                 return Row(
//                   children: [
//                     TextWidget(
//                       text: 'Delivering to - ',
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     TextWidget(
//                       text: "${value?.address?.tag} : ",
//                       color: Colors.red,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     Expanded(
//                       child: TextWidget(
//                         text:
//                             "${value?.address?.street} ${value?.address?.locality} ${value?.address?.city} ${value?.address?.state} ${value?.address?.zip}",
//                         textOverflow: TextOverflow.ellipsis,
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ).toList();
//           },
//           onChanged: (value) {
//             onChanged(value);
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../logic/common/dropdown_widget_cubit_address.dart';

class DropDownAddressWidget extends StatelessWidget {
  const DropDownAddressWidget({
    Key? key,
    required this.context,
    required this.list,
    required this.selectedValue,
    required this.onChanged,
    this.readOnly = false,
    this.isRounded = true,
  }) : super(key: key);

  final BuildContext context;
  final List<AddressElement> list;
  final AddressElement? selectedValue;
  final Function onChanged;
  final bool readOnly;
  final bool isRounded;

  @override
  Widget build(BuildContext context) {
    final List<AddressElement> modifiedList = [
      ...list,
      AddressElement.defaultAddress(),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffBFBCBC).withOpacity(0.3),
        borderRadius: isRounded ? BorderRadius.circular(12) : null,
      ),
      padding: EdgeInsets.only(top: 8.h, bottom: 10.h, left: 10.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AddressElement>(
          value: selectedValue,
          isExpanded: true,
          isDense: true,
          dropdownColor: AppColors.whiteColor,
          icon: Padding(
            padding: EdgeInsets.only(
              right: 11.w,
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 24.h,
            ),
          ),
          items: modifiedList.map((AddressElement? value) {
            return DropdownMenuItem(
              value: value,
              child: Row(
                children: [
                  TextWidget(
                    text: value?.address?.tag == 'default'
                        ? ''
                        : "${value?.address?.tag} - ",
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: TextWidget(
                      text:
                          "${value?.address?.street ?? ''} ${value?.address?.locality ?? ''} ${value?.address?.city ?? ''} ${value?.address?.state ?? ''} ${value?.address?.zip ?? ''}",
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return modifiedList.map<Widget>(
              (AddressElement? value) {
                return Row(
                  children: [
                    TextWidget(
                      text: 'Delivering to - ',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    TextWidget(
                      text: value?.address?.tag == null
                          ? value?.address?.tag ?? ''
                          : "${value?.address?.tag} : ",
                      color: Colors.red,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Expanded(
                      child: TextWidget(
                        text:
                            "${value?.address?.street ?? ''} ${value?.address?.locality ?? ''} ${value?.address?.city ?? ''} ${value?.address?.state ?? ''} ${value?.address?.zip ?? ''}",
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ).toList();
          },
          onChanged: (value) {
            if (value != null && value.addressId == 1234) {
              context.push(Routes.profileScreen);
              context.read<DropdownAddressCubit>().updateSelected(list.first);
            }
            onChanged(value);
          },
        ),
      ),
    );
  }
}
