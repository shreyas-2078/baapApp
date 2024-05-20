// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/constants/app_enum.dart';
import 'package:baapapp/constants/app_sizes.dart';
import 'package:baapapp/constants/app_strings.dart';
import 'package:baapapp/logic/image_upload/image_upload_cubit.dart';
import 'package:baapapp/logic/menu_logic/menu_cubit.dart';
import 'package:baapapp/logic/service_action/service_action_cubit.dart';
import 'package:baapapp/logic/sub_category_list/sub_category_list_cubit.dart';
import 'package:baapapp/main.dart';
import 'package:baapapp/utils/app_utils/extensions.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/in_app_web_view_screen.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';

import 'package:baapapp/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';

import '../../constants/app_images.dart';
import '../../utils/app_utils/app_utils.dart';
import '../../widgets/sub_category_list_tile.dart';

class ListSubCategory extends StatefulWidget {
  const ListSubCategory({
    super.key,
    this.categoryName,
    this.subCategoryId,
  });

  final String? categoryName;
  final int? subCategoryId;

  @override
  State<ListSubCategory> createState() => _ListSubCategoryState();
}

class _ListSubCategoryState extends State<ListSubCategory> {
  @override
  void initState() {
    context
        .read<SubCategoryListCubit>()
        .getSubCategoryList(widget.subCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String latGetStorage = GetStorage().read('latitude') ?? "00.00000";
    String longGetStorage = GetStorage().read('longitude') ?? "00.00000";
    String? locationName = LocalStorageUtils.getLocationName();
    String? locationPin = LocalStorageUtils.getlocationPin();

    return SafeArea(
      child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundDark,
            appBar: AppBar(
              systemOverlayStyle: systemOverLayStyle,
              surfaceTintColor: Colors.white10,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              automaticallyImplyLeading: true,
              elevation: 0,
              backgroundColor: AppColors.backgroundDark,
              title: TextWidget(
                text: widget.categoryName.toString().capitalize(),
                color: AppColors.whiteColor,
                fontSize: 17.sp,
              ),
            ),
            body: Stack(children: [
              SizedBox(
                child: BlocBuilder<SubCategoryListCubit, SubCategoryListState>(
                  builder: (context, state) {
                    if (state is SubCategoryListLoading) {
                      return Center(
                        child: SizedBox(
                          height: 200.h,
                          width: 200.w,
                          child: Lottie.asset(AppImages.loadingWhiteAnimation),
                        ),
                      );
                    }
                    if (state is SubCategoryListError) {
                      return Center(
                          child: TextWidget(
                        text: 'Something was wrong . . .',
                        fontSize: 17.sp,
                        color: Colors.white,
                      ));
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 10.h,
                      ),
                      padding: EdgeInsets.only(left: 15.h, right: 15.h),
                      itemCount: state.subCategoryListModel?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var item = state.subCategoryListModel?[index];
                        return ListSubCategoryTile(
                          data: item,
                          onPressed: () async {
                            var user = await LocalStorageUtils.fetchToken();
                            if (user?.isEmpty ?? false) {
                              context.push(Routes.signupScreen);
                            } else {
                              var uId =
                                  LocalStorageUtils.tokenResponseModel.userId;
                              if (state.subCategoryListModel?[index].action ==
                                  ClickAction.whatsapp.name) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: AlertDialog(
                                          insetPadding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor:
                                              const Color(0XFFEFEFEF),
                                          elevation: 16,
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 20.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidget(
                                                  text:
                                                      'तुम्हाला खरंच ${state.subCategoryListModel?[index].name} पाहिजे आहे का?',
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0XFF5C3F3F),
                                                ),
                                                const SizedBoxWidget(
                                                    height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ServiceActionCubit>()
                                                            .serviceAction(
                                                              subCategoryId: state
                                                                  .subCategoryListModel?[
                                                                      index]
                                                                  .subcategoryId,
                                                              userId: uId,
                                                              categoryId: state
                                                                  .subCategoryListModel?[
                                                                      index]
                                                                  .categoryId,
                                                            );
                                                        Navigator.pop(context);
                                                        FocusNode().unfocus();
                                                      },
                                                      child: Container(
                                                        width: 70.w,
                                                        height: 35.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF707070),
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                        ),
                                                        child: Center(
                                                          child: TextWidget(
                                                            text: 'हो',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            color: const Color(
                                                                0XFF5C3F3F),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBoxWidget(
                                                        width: 10),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        FocusNode().unfocus();
                                                      },
                                                      child: Container(
                                                        width: 70.w,
                                                        height: 35.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xFF707070),
                                                              width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.r),
                                                        ),
                                                        child: Center(
                                                          child: TextWidget(
                                                            text: 'नाही',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            color: const Color(
                                                                0XFF5C3F3F),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else if (state
                                      .subCategoryListModel?[index].action ==
                                  ClickAction.webpage.name) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InAppWebViewVidget(
                                      categoryName: state
                                          .subCategoryListModel?[index].name,
                                      url:
                                          "${state.subCategoryListModel?[index].webpageUrl}?groupId=${apiEndpoints.experienceGroupId}&userId=$uId&categoryId=${state.subCategoryListModel?[index].categoryId}&subcategoryId=${state.subCategoryListModel?[index].subcategoryId}&lat=$latGetStorage&lon=$longGetStorage&locationName=$locationName&locationPin=$locationPin",
                                    );
                                  },
                                );
                              } else if (state
                                      .subCategoryListModel?[index].action ==
                                  ClickAction.document.name) {
                                _showButtomModelSheet(
                                  context,
                                  isCamera: false,
                                  subCategoryId: state
                                      .subCategoryListModel?[index]
                                      .subcategoryId,
                                  userId: uId,
                                  categoryId: state
                                      .subCategoryListModel?[index].categoryId,
                                );
                              } else if (state
                                      .subCategoryListModel?[index].action ==
                                  ClickAction.list.name) {
                                context
                                    .push(Routes.listSubCategoryScreen, extra: {
                                  "categoryName":
                                      state.subCategoryListModel?[index].name ??
                                          "",
                                  "subCategoryId": state
                                      .subCategoryListModel?[index]
                                      .subcategoryId,
                                });
                              } else if (state
                                      .subCategoryListModel?[index].action ==
                                  ClickAction.productList.name) {
                                context.push(Routes.productScreen, extra: {
                                  "serviceRequest": true,
                                  "subCategoryId": state
                                      .subCategoryListModel?[index]
                                      .subcategoryId,
                                  'subCategoryName':
                                      state.subCategoryListModel?[index].name,
                                  "categoryId": state
                                      .subCategoryListModel?[index].categoryId,
                                  "groupId": apiEndpoints.experienceGroupId,
                                  "subGroupId": state
                                      .subCategoryListModel?[index].groupId,
                                });
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              context.watch<ServiceActionCubit>().state is ServiceActionLoading
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3,
                        sigmaY: 3,
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: Lottie.asset(
                            AppImages.loadingAnimation,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              context.watch<ServiceActionCubit>().state is ServiceActionLoaded
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3,
                        sigmaY: 3,
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 40.h,
                                ),
                              ),
                              const SizedBoxWidget(
                                height: 10,
                              ),
                              TextWidget(
                                text: 'तुमची विनंती बाप टीमला पाठवली आहे.',
                                color: Colors.black,
                                fontSize: 17.sp,
                                textDecoration: TextDecoration.none,
                                fontWeight: FontWeight.w600,
                              ),
                              TextWidget(
                                text:
                                    'तुम्हाला टीम कडून लवकरच प्रतिसाद देण्यात येईल.',
                                color: Colors.black,
                                fontSize: 17.sp,
                                textDecoration: TextDecoration.none,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ]),
            bottomNavigationBar:
                BlocBuilder<SubCategoryListCubit, SubCategoryListState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 15,
                    right: 15,
                  ),
                  color: AppColors.backgroundDark,
                  child: state.subCategoryListModel?.first.isGovernmentScheme ??
                          false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(
                              text: "Note :",
                              color: const Color(0XFFE676A4),
                              fontSize: 13.sp,
                            ),
                            TextWidget(
                              text:
                                  "All this information is derived from authorized Government websites. we do not hold any authority over this information",
                              color: AppColors.textGrey,
                              fontSize: 12.sp,
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: "Made in Paregaon LIVE with ",
                              color: Colors.grey,
                              fontSize: 13.sp,
                            ),
                            TextWidget(
                              text: "Pride",
                              color: const Color(0XFFE676A4),
                              fontSize: 12.sp,
                            )
                          ],
                        ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showButtomModelSheet(
    BuildContext context, {
    int? subCategoryId,
    int? userId,
    int? categoryId,
    bool? isCamera,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ImageUploadCubit, ImageUploadState>(
            builder: (context, state) {
              if (state is ImageUploadLoading) {
                return Container(
                  height: 130.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: const Center(
                    child: CustomCircularProgressIndidator(),
                  ),
                );
              }
              if (state is ImageUploadSuccess) {
                var image = state.url;
                var imageName = state.fileName;
                return Container(
                  height: 310.h,
                  color: AppColors.backgroundLight,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'तुम्ही हा फोटो अपलोड करू इच्छिता ?',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF9F9F9F),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl: image ?? '',
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            buttonText: 'नाही',
                            width: 100,
                            buttonTextSize: 15.sp,
                            onPress: () {
                              context.read<ImageUploadCubit>().changeState();
                            },
                          ),
                          const SizedBoxWidget(width: 10),
                          CustomButton(
                            buttonText: 'होय',
                            width: 100,
                            buttonTextSize: 15.sp,
                            textColor: AppColors.whiteColor,
                            color: Colors.green,
                            onPress: () {
                              if (isCamera ?? false) {
                                context
                                    .read<ServiceActionCubit>()
                                    .serviceActionByUserId(
                                      userId: userId,
                                      image:
                                          "${apiEndpoints.imageResizeBaseUrl}resize-image?size=300x200&path=$imageName",
                                    );
                              } else {
                                context
                                    .read<ServiceActionCubit>()
                                    .serviceAction(
                                      categoryId: categoryId,
                                      subCategoryId: subCategoryId,
                                      userId: userId,
                                      image:
                                          "${apiEndpoints.imageResizeBaseUrl}resize-image?size=300x200&path=$imageName",
                                    );
                              }

                              context.pop();
                              context.read<ImageUploadCubit>().changeState();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Container(
                height: 180.h,
                //change
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: AppSizes.horizontalPadding15px,
                  right: AppSizes.horizontalPadding15px,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: TextWidget(
                          color: const Color(0XFFC8E676),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          text:
                              "आपल्याला हव्या असलेल्या सामानाची, औषधांची यादी किंवा हव्या असलेल्या सुविधेचे वर्णन आपण फोटोद्वारे येथे अपलोड करू शकता.",
                        ),
                      ),
                      const Divider(color: AppColors.textGreyColor),
                      InkWell(
                        onTap: () {
                          context
                              .read<ImageUploadCubit>()
                              .captureAndUploadImage(context);
                        },
                        child: TextWidget(
                          text: AppStrings.takePhoto,
                          fontSize: 16.sp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBoxWidget(
                        height: 5.h,
                      ),
                      const DottedLine(dashColor: AppColors.textGreyColor),
                      SizedBoxWidget(
                        height: 5.h,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<ImageUploadCubit>().pickImage(context);
                        },
                        child: TextWidget(
                          text: AppStrings.uploadImage,
                          fontSize: 16.sp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ]),
              );
            },
          );
        });
  }
}
