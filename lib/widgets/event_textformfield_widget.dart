import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class EventTextformFieldWidget extends StatefulWidget {
  const EventTextformFieldWidget({
    super.key,
    this.formFieldKey,
    this.hintText,
    this.height,
    this.rouneded = 0,
    this.fontWeight = FontWeight.normal,
    this.focusNode,
    this.suffixIcon,
    this.isSuffixIconShow = false,
    this.isRounded = false,
    this.readOnly = false,
    this.backgroundColor = AppColors.textformFieldColor,
    this.controller,
    this.textInputType,
    this.inputFormater,
    this.onChanged,
    this.initialValue,
    this.isBorderColor = false,
    this.isEditable = true,
    this.hintTextColor = AppColors.blackColor,
    this.fontSize,
    this.suffixIconClick,
    this.width,
    this.validator,
    this.maxLength,
    this.maxLines,
    this.cursorColor,
    this.fontColor,
    this.isBorder = false, 
    this.onOutSideTap,
  });

  final GlobalKey<FormState>? formFieldKey;
  final String? initialValue;
  final bool isSuffixIconShow;
  final bool readOnly;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final double? height;
  final double? width;
  final double rouneded;
  final bool isRounded;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconClick;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormater;
  final FormFieldValidator<String>? validator;
  final bool isBorderColor;
  final bool isBorder;
  final Color? cursorColor;
  final Color? fontColor;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onOutSideTap;
  final bool isEditable;

  @override
  State<EventTextformFieldWidget> createState() =>
      _EventTextformFieldWidgetState();
}

class _EventTextformFieldWidgetState extends State<EventTextformFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.isRounded ? BorderRadius.circular(32) : null,
      ),
      width: widget.width,
      child: Form(
        key: widget.formFieldKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          enabled: widget.isEditable,
          initialValue: widget.initialValue,
          onTapOutside: widget.onOutSideTap,
          cursorColor: widget.cursorColor ?? AppColors.whiteColor,
          inputFormatters: widget.inputFormater,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines ?? 1,
          onChanged: widget.onChanged,
          style: GoogleFonts.kumbhSans(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color:
                  widget.fontColor ?? Theme.of(context).secondaryHeaderColor),
          decoration: InputDecoration(
            suffix: widget.isSuffixIconShow
                ? InkWell(
                    onTap: widget.suffixIconClick,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 5.w,
                        top: 5,
                      ),
                      child: Icon(
                        widget.suffixIcon,
                        color: widget.fontColor,
                      ),
                    ),
                  )
                : const SizedBox(),
            contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 12.w,
              // top: 7.h,
              bottom: 6.h,
            ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.kumbhSans(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: widget.hintTextColor ??
                  Theme.of(context).secondaryHeaderColor,
            ),
            errorStyle: GoogleFonts.kumbhSans(
              fontSize: 14.sp,
              fontWeight: widget.fontWeight,
              color: Colors.red,
            ),
            focusedBorder: widget.isRounded
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.rouneded),
                    borderSide: BorderSide(
                      color: widget.isBorderColor
                          ? AppColors.whiteColor.withOpacity(0.5)
                          : AppColors.lightGreyColor.withOpacity(0.5),
                      width: 1.0,
                    ),
                  )
                : widget.isBorder
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.isBorderColor
                              ? AppColors.lightGreyColor.withOpacity(0.5)
                              : AppColors.lightGreyColor.withOpacity(0.5),
                          width: 1.0,
                        ),
                      )
                    : InputBorder.none,
            border: widget.isBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.rouneded,
                    ),
                    borderSide: BorderSide(
                      color: widget.isBorderColor
                          ? AppColors.lightGreyColor.withOpacity(0.5)
                          : Colors.transparent.withOpacity(0.5),
                      width: 1.0,
                    ),
                  )
                : widget.isBorder
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.isBorderColor
                              ? AppColors.borderColor.withOpacity(0.5)
                              : Colors.transparent.withOpacity(0.5),
                          width: 1.0,
                        ),
                      )
                    : InputBorder.none,
          ),
        ),
      ),
    );
  }
}
