import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownFormWidget extends StatelessWidget {
  const DropDownFormWidget({
    Key? key,
    required this.context,
    required this.list,
    required this.selectedValue,
    required this.onChanged,
    this.readOnly = false,
    this.isRounded = true,
  }) : super(key: key);

  final BuildContext context;
  final List<String> list;
  final String selectedValue;
  final Function onChanged;
  final bool readOnly;
  final bool isRounded;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.editTextformFieldColor.withOpacity(0.5),
        borderRadius: isRounded ? BorderRadius.circular(12) : null,
      ),
      padding: EdgeInsets.only(top: 8.h, bottom: 10.h, left: 15.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue.isEmpty
              ? (list.isNotEmpty ? list[0] : selectedValue)
              : selectedValue,
          isExpanded: true,
          isDense: true,
          dropdownColor: AppColors.editTextformFieldColor,
          icon: Padding(
            padding: EdgeInsets.only(
              right: 11.w,
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white.withOpacity(0.3),
              size: 24.h,
            ),
          ),
          items: list.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: TextWidget(
                text: value.toString(),
                color: AppColors.textGrey,
                fontSize: 17.sp,
                
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return list.map<Widget>(
              (String value) {
                return TextWidget(
                  text: value.toString(),
                  fontSize: 18.sp,
                  color: AppColors.textGrey
                );
              },
            ).toList();
          },
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
