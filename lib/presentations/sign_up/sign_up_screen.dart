import 'dart:developer';
import 'package:baapapp/logic/signup_logic/signup_screen_cubit.dart';
import 'package:baapapp/widgets/count_timer_widget.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/in_app_web_view_screen.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../utils/app_utils/snackbar/snackbar.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/textformfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController(text: "");
  final TextEditingController otpController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController pinController = TextEditingController(text: "");
  final TextEditingController addressController =
      TextEditingController(text: "");

  bool isArrowIconVisible = true;

  bool sendOtp = false;
  bool otpVerified = false;
  bool passwordVisible = true;
  bool isButtonDisabled = false;

  @override
  void initState() {
    sendOtp = false;
    otpVerified = false;
    super.initState();
  }

  @override
  void dispose() {
    sendOtp = false;
    otpVerified = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is UserLoggedIn) {
          context.push(Routes.homePageScreen);
        } else if (state is SendOtpError) {
          SnackBarWidget.showSnackbar(context, state.errorMesage ?? "",
              color: const Color(0xFFF50057));
        } else if (state is VerifyOtpError) {
          SnackBarWidget.showSnackbar(
            context,
            state.errorMesage ?? "",
            color: const Color(0xFFF50057),
          );
        }
      },
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return SafeArea(
            // ignore: deprecated_member_use
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topContainer(),
                    _lastContainer(),
                  ],
                ),
                bottomNavigationBar: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const InAppWebViewVidget(
                            categoryName: 'Terms & Conditions',
                            url: 'https://content.baapmarket.com/policy');
                      },
                    );
                  },
                  child: Container(
                    color: AppColors.backgroundDark.withOpacity(0.8),
                    height: 35.h,
                    width: 80.w,
                    child: Center(
                      child: TextWidget(
                        text: 'Terms & Conditions',
                        color: AppColors.whiteColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _topContainer() {
    return Container(
        height: 300.h,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: AppColors.backgroundLight,
            image: DecorationImage(
              image: AssetImage('assets/images/img.jpeg'),
              opacity: 0.2,
              fit: BoxFit.fill,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 10.h),
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                    ),
                    const SizedBoxWidget(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'Login',
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'THE',
                      color: AppColors.textGreyColor,
                      fontSize: 29.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBoxWidget(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'BAAP',
                      color: AppColors.textYellowColor,
                      fontSize: 29.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBoxWidget(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'APP',
                      color: AppColors.textGreyColor,
                      fontSize: 29.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                TextWidget(
                  text: 'तुमची माहिती भरा ',
                  color: AppColors.textGreenColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox()
          ],
        ));
    // Positioned(
    //     top: 170,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //
    // ],
    // ))
  }

  _lastContainer() {
    return Expanded(
        flex: 1,
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is SendOtpSuccess) {
              sendOtp = true;
            }
            if (state is VerifyOtpUserNotExists) {
              otpVerified = true;
            }
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  color: AppColors.backgroundDark,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBoxWidget(
                            height: 10,
                          ),
                          TextWidget(
                            text:
                                'कृपया तुमचा व्हाट्सअँप नंबर टाका. आम्ही तुम्हाला तुमच्या व्हाट्सअँप नंबर वरती एक OTP पाठवू ',
                            fontSize: 12.sp,
                            color: AppColors.textGrey,
                          ),
                          const SizedBoxWidget(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextformFieldWidget(
                                  hintText: 'मोबाईल नंबर',
                                  fontSize: 20.sp,
                                  textInputType: TextInputType.number,
                                  isEnable: !otpVerified,
                                  onOutSideTap: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "कृपया मोबाइल नंबर टाका";
                                    }
                                    if (value.length != 10) {
                                      return "कृपया 10 अंकी क्रमांक टाका";
                                    }
                                    return null;
                                  },
                                  inputFormater: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: phoneNumber,
                                  errorTextColor: const Color(0xFFF50057),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (!isButtonDisabled &&
                                        formkey.currentState!.validate()) {
                                      setState(() {
                                        isButtonDisabled = true;
                                      });
                                      context.read<SignUpCubit>().sendOtp(
                                            phoneNumber.text.trim(),
                                            context,
                                          );
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  },
                                  child: state is SendOtpLoading
                                      ? const Center(
                                          child:
                                              CustomCircularProgressIndidator())
                                      : const Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.whiteColor,
                                          size: 25,
                                        ))
                            ],
                          ),
                          const SizedBoxWidget(
                            height: 10,
                          ),
                          sendOtp
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: TextformFieldWidget(
                                        hintText: 'OTP',
                                        fontSize: 20.sp,
                                        obscureText: passwordVisible,
                                        onOutSideTap: (event) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        textInputType: TextInputType.number,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: passwordVisible
                                                ? AppColors
                                                    .editTextformFieldColor
                                                : AppColors.whiteColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                        ),
                                        inputFormater: [
                                          LengthLimitingTextInputFormatter(6),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: otpController,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          try {
                                            int otpValue = int.parse(
                                                otpController.text.trim());
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            context
                                                .read<SignUpCubit>()
                                                .verifyOtp(
                                                  phoneNumber: phoneNumber.text,
                                                  otp: otpValue,
                                                );
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                        },
                                        child: state is VerifyOtpLoading
                                            ? const Center(
                                                child:
                                                    CustomCircularProgressIndidator())
                                            : const Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.whiteColor,
                                                size: 25,
                                              ))
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBoxWidget(height: 5),
                          sendOtp && isButtonDisabled
                              ? Row(
                                  children: [
                                    TextWidget(
                                      text: 'Dont receive it? Retry - ',
                                      fontSize: 16.sp,
                                      color:
                                          AppColors.whiteColor.withOpacity(0.8),
                                    ),
                                    CountDownTimer(
                                      secondsRemaining: 60,
                                      whenTimeExpires: () {
                                        setState(() {
                                          isButtonDisabled = false;
                                        });
                                        // otpController.clear();
                                      },
                                      whenTimeSeconds: () {},
                                      textAlign: TextAlign.left,
                                      color: AppColors.whiteColor,
                                      fontSize: 17.sp,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBoxWidget(height: 10),
                          otpVerified
                              ? Column(
                                  children: [
                                    TextformFieldWidget(
                                      fontSize: 20.sp,
                                      hintText: 'तुमचे नाव टाका',
                                      controller: nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "कृपया नाव टाका";
                                        }
                                        RegExp regex =
                                            RegExp(r'^[^ ](?!.*\s\s).*');

                                        if (!regex.hasMatch(value)) {
                                          return "कृपया बरोबर नाव टाका";
                                        }

                                        return null;
                                      },
                                      onOutSideTap: (event) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                                    const SizedBoxWidget(
                                      height: 10,
                                    ),
                                    TextformFieldWidget(
                                      fontSize: 20.sp,
                                      hintText: 'पिनकोड',
                                      controller: pinController,
                                      textInputType: TextInputType.number,
                                      onOutSideTap: (event) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      inputFormater: [
                                        LengthLimitingTextInputFormatter(6),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    const SizedBoxWidget(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextformFieldWidget(
                                                fontSize: 20.sp,
                                                hintText: 'तुमचे गाव/शहर टाका',
                                                controller: addressController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "कृपया तुमचे गाव/शहर  टाका";
                                                  }
                                                  // Check for space in the name
                                                  RegExp regex = RegExp(
                                                      r'^[^ ](?!.*\s\s).*');

                                                  if (!regex.hasMatch(value)) {
                                                    return "कृपया तुमचे गाव/शहर बरोबर टाका";
                                                  }
                                                  return null;
                                                },
                                                onOutSideTap: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                              ),
                                            ),
                                            InkWell(
                                              child: state
                                                      is CustomerInfoLoading
                                                  ? const Center(
                                                      child:
                                                          CustomCircularProgressIndidator())
                                                  : const Center(
                                                      child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:
                                                          AppColors.whiteColor,
                                                      size: 25,
                                                    )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<SignUpCubit>()
                                                .saveUserProfile(
                                                    phoneNumber.text,
                                                    nameController.text,
                                                    pinController.text,
                                                    addressController.text);
                                          },
                                          child: Container(
                                              height: 35.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .textDarkGreyColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32)),
                                              child: state
                                                      is CustomerInfoLoading
                                                  ? const Center(
                                                      child:
                                                          CustomCircularProgressIndidator())
                                                  : Center(
                                                      child: TextWidget(
                                                      text: 'Register',
                                                      color: AppColors
                                                          .whiteColor
                                                          .withOpacity(0.8),
                                                      fontSize: 15.sp,
                                                    ))),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
