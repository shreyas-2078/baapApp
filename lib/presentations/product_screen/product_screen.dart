import 'dart:ui';
import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/constants/app_images.dart';
import 'package:baapapp/constants/app_sizes.dart';
import 'package:baapapp/constants/app_strings.dart';
import 'package:baapapp/logic/bussiness_detail/bussiness_detail_cubit.dart';
import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/logic/group_data/group_data_cubit.dart';
import 'package:baapapp/logic/image_upload/image_upload_cubit.dart';
import 'package:baapapp/logic/product_category/product_category_cubit.dart';
import 'package:baapapp/logic/product_screen/product_screen_cubit.dart';
import 'package:baapapp/logic/service_action/service_action_cubit.dart';
import 'package:baapapp/main.dart';
import 'package:baapapp/utils/app_utils/app_utils.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/event_textformfield_widget.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:baapapp/widgets/product_card.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletons/skeletons.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    this.subCategoryId,
    this.categoryId,
    this.groupId,
    this.subCategoryName,
    this.serviceRequest,
    this.subGroupId,
    this.businessId,
  });

  final int? subCategoryId;
  final int? categoryId;
  final int? groupId;
  final int? subGroupId;
  final int? businessId;
  final String? subCategoryName;
  final bool? serviceRequest;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int? selectedIndex;
  int? selectedCategory;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    selectedCategory = widget.categoryId;
    context
        .read<GroupDataCubit>()
        .getGroupData(groupId: widget.subGroupId ?? widget.groupId);
    context.read<ProductCategoryCubit>().getCategoryByGroupId(context);

    if (widget.subGroupId != null) {
      context.read<BussinessDetailCubit>().getBussiesDetails(widget.subGroupId);
    }

    context.read<CartCubit>().getCart(
          groupId: widget.groupId,
        );

    if (widget.subCategoryId != null) {
      context.read<ProductListCubit>().getProductBySubCategoryId(
          subcategoryId: widget.subCategoryId, groupId: widget.groupId);
    } else {
      selectedIndex = -1;
      selectedCategory = null;
      context
          .read<ProductListCubit>()
          .getProductByCategoryId(groupId: widget.groupId);
    }
    if (widget.subCategoryName != '') {
      _searchController.text = widget.subCategoryName ?? '';
    }
    super.initState();
  }

  bool isCamera = true;
  bool isChat = false;
  bool isPhone = false;
  bool isProduct = false;
  bool innerBoxIsScrolled = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Scaffold(
          backgroundColor: AppColors.productScreenBackground.withOpacity(1.0),
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, innerBoxIsScrolled) {
                  innerBoxIsScrolled = innerBoxIsScrolled;
                  return <Widget>[
                    SliverAppBar(
                      stretch: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: 150.h,
                      collapsedHeight: 115.h,
                      backgroundColor: AppColors.whiteColor.withOpacity(0.5),
                      systemOverlayStyle: systemOverLayStyle,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        titlePadding: EdgeInsets.zero,
                        collapseMode: CollapseMode.pin,
                        title: _headerWidget(),
                      ),
                    ),
                  ];
                },
                body: BlocBuilder<BussinessDetailCubit, BussinessDetailState>(
                  builder: (context, state) {
                    if (state is BussinessDetailLoading) {
                      return const Center(
                        child: CustomCircularProgressIndidator(),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleWidget(innerBoxIsScrolled),
                        SizedBox(
                          height: 10.h,
                        ),
                        widget.serviceRequest != null
                            ? _searchBarWidget()
                            : isProduct
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: "माहिती ",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidget(
                                            text: state
                                                .bussinessDetail?.first.desc,
                                            fontSize: 13.sp,
                                          ),
                                        ]),
                                  ),
                        const SizedBoxWidget(
                          height: 10,
                        ),
                        widget.serviceRequest != null
                            ? _categoryWidget()
                            : const SizedBox(),
                        SizedBox(
                          height: 5.h,
                        ),
                        widget.serviceRequest != null
                            ? Expanded(child: _productContainerWidget())
                            : const SizedBox(),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
              context.watch<ProductListCubit>().state is ProductListError
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3,
                        sigmaY: 3,
                      ),
                      child: Container(
                          color: Colors.white.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.pop();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30.h,
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                child: TextWidget(
                                  text: 'काही तरी चुकल आहे,',
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(),
                            ],
                          )),
                    )
                  : const SizedBox(),
              Positioned(
                top: 5,
                left: 8,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5), // Dark color
                    ),
                    padding:
                        const EdgeInsets.all(8), // Adjust padding as needed
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white, // Icon color
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
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
                              'तुम्हाला टीम काढून लवकरच प्रतिसाद देण्यात येईल.',
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
            : const SizedBox(),
      ]),
    );
  }

  _headerWidget() {
    return BlocBuilder<GroupDataCubit, GroupDataState>(
        builder: (context, state) {
      if (state is GroupDataLoading) {
        return const Center(
          child: CustomCircularProgressIndidator(),
        );
      }
      return SizedBox(
        height: 150.h,
        child: Image.network(
          state.groupData?.mobileCoverImage ?? "",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
      );
    });
  }

  _titleWidget(bool innerBoxIsScrolled) {
    return BlocBuilder<GroupDataCubit, GroupDataState>(
        builder: (context, state) {
      return Container(
        color: AppColors.whiteColor.withOpacity(0.5),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: state.groupData?.name ?? "",
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                    fontSize: 15.sp,
                  ),
                  SizedBox(
                    width: 200.w,
                    child: TextWidget(
                      text: state.groupData?.description ?? "",
                      fontSize: 13.sp,
                      textOverflow: TextOverflow.ellipsis,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  isChat
                      ? SvgPicture.asset('assets/images/chat_outline.svg')
                      : const SizedBox(),
                  SizedBox(
                    width: 10.w,
                  ),
                  state.groupData?.commonSettings?.enableCamera ?? false
                      ? InkWell(
                          onTap: () {
                            int? userId =
                                LocalStorageUtils.tokenResponseModel.userId;
                            _showButtomModelSheet(
                              context,
                              userId: userId,
                              categoryId: widget.categoryId,
                              groupId: widget.subGroupId,
                              bussinessId: widget.businessId,
                              subCategoryId: widget.subCategoryId,
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/outline_camera.svg',
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: 10.w,
                  ),
                  isPhone ? const Icon(Icons.phone) : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  _searchBarWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<ProductListCubit, ProductListState>(
              builder: (context, state) {
                return EventTextformFieldWidget(
                  rouneded: 32,
                  width: 250.w,
                  controller: _searchController,
                  hintText: "प्रॉडक्ट शोधा. ",
                  hintTextColor: AppColors.textGreyColor,
                  cursorColor: AppColors.textGreyColor,
                  backgroundColor: AppColors.whiteColor.withOpacity(0.5),
                  fontColor: AppColors.blackColor,
                  fontSize: 17.sp,
                  isBorder: true,
                  isRounded: true,
                  isSuffixIconShow: true,
                  suffixIcon: Icons.clear_rounded,
                  suffixIconClick: () {
                    selectedIndex = -1;
                    selectedCategory = null;
                    _searchController.clear();
                    setState(() {});
                    context.read<ProductListCubit>().getProductByCategoryId(
                          groupId: widget.groupId,
                        );
                  },
                  onChanged: (String? value) {
                    if ((value?.length ?? 0) > 2) {
                      context.read<ProductListCubit>().getProductBySearch(
                          groupId: widget.groupId, value: value);
                      selectedIndex = -1;
                      selectedCategory = null;
                      setState(() {});
                    } else if (value?.isEmpty ?? true) {
                      selectedIndex = -1;
                      selectedCategory = null;
                      context.read<ProductListCubit>().getProductByCategoryId(
                            groupId: widget.groupId,
                          );
                    }
                  },
                );
              },
            ),
          ),
          const SizedBoxWidget(
            width: 10,
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartAddSuccess) {
                context.read<CartCubit>().getCart(groupId: widget.groupId);
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: InkWell(
                    onTap: () {
                      context.push(Routes.shoppingScreen, extra: {
                        "groupId": widget.groupId,
                      });
                    },
                    child: Badge.count(
                      count: state.data?.data?.products?.length ?? 0,
                      backgroundColor: const Color(0XFF8DE009),
                      smallSize: 10.h,
                      largeSize: 17.h,
                      textColor: Colors.black,
                      textStyle: TextStyle(fontSize: 13.sp),
                      child: Icon(Icons.shopping_bag_outlined, size: 30.h),
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkWell(
                  onTap: () {
                    context.push(Routes.shoppingScreen, extra: {
                      "groupId": widget.groupId,
                    });
                  },
                  child: Badge.count(
                    count: state.data?.data?.products?.length ?? 0,
                    backgroundColor: const Color(0XFF8DE009),
                    smallSize: 10.h,
                    largeSize: 17.h,
                    textColor: Colors.black,
                    textStyle: TextStyle(fontSize: 13.sp),
                    child: Icon(Icons.shopping_bag_outlined, size: 30.h),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _categoryWidget() {
    return BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
      builder: (context, state) {
        if (state is ProductCategoryLoading) {
          return SizedBox(
            height: 30.h,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.w),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 100.w),
                  ),
                );
              },
            ),
          );
        }
        return Container(
          height: 24.h,
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding10px,
            right: AppSizes.horizontalPadding10px,
          ),
          margin: EdgeInsets.only(
            bottom: AppSizes.verticalPadding10px,
          ),
          child: SizedBox(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.productCategoryModel?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = state.productCategoryModel?[index];
                  if (item?.categoryId == selectedCategory) {
                    selectedIndex = index;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? Container(
                              padding: EdgeInsets.only(right: 20.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = -1;
                                    selectedCategory = null;
                                    _searchController.clear();
                                    context
                                        .read<ProductListCubit>()
                                        .getProductByCategoryId(
                                          groupId: widget.groupId,
                                        );
                                  });
                                },
                                child: TextWidget(
                                  //change
                                  text: "सर्व",
                                  color: selectedIndex == -1
                                      ? AppColors.blackColor
                                      : AppColors.textGreyColor,
                                  fontSize: 19.sp,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      (item?.product == true)
                          ? Container(
                              padding: EdgeInsets.only(right: 20.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedCategory = item?.categoryId;
                                    _searchController.clear();
                                    context
                                        .read<ProductListCubit>()
                                        .getProductByCategoryId(
                                          categoryId: item?.categoryId,
                                          groupId: widget.groupId,
                                        );
                                  });
                                },
                                child: TextWidget(
                                  text: item?.name,
                                  color: selectedIndex == index
                                      ? AppColors.blackColor
                                      : AppColors.textGreyColor,
                                  fontSize: 19.sp,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }

  _productContainerWidget() {
    return BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
      if (state is ProductListLoading) {
        return Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: GridView.builder(
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  height: 170.h,
                  width: 160.w,
                  child: const SkeletonAvatar(
                    style: SkeletonAvatarStyle(),
                  ),
                );
              }),
        );
      }
      if (state.productModel?.isEmpty ?? false) {
        return Center(
          child: TextWidget(
            text: 'प्रॉडक्ट भेटले नाही.',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.productModel?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = state.productModel?[index];
                  return InkWell(
                    onTap: () {
                      context.push(
                        Routes.productDetailSCreen,
                        extra: {
                          'item': item,
                          'groupId': widget.groupId,
                        },
                      );
                    },
                    child: ProductCard(
                      productModel: item,
                      productId: item?.productcode,
                      groupId: widget.groupId,
                      subGroupId: widget.subGroupId,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showButtomModelSheet(
    BuildContext context, {
    int? subCategoryId,
    int? userId,
    int? groupId,
    int? bussinessId,
    int? categoryId,
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
                              if (widget.businessId != null) {
                                context
                                    .read<ServiceActionCubit>()
                                    .serviceAction(
                                      groupId: groupId,
                                      categoryId: categoryId,
                                      subCategoryId: subCategoryId,
                                      userId: userId,
                                      bussinessId: bussinessId,
                                      image:
                                          "${apiEndpoints.imageResizeBaseUrl}resize-image?size=300x200&path=$imageName",
                                    );
                              } else {
                                context
                                    .read<ServiceActionCubit>()
                                    .serviceActionByUserId(
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
                height: 190.h,
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
  // _detailWidget() {
  //   return BlocBuilder<BussinessDetailCubit, BussinessDetailState>(
  //     builder: (context, state) {
  //       if (state is BussinessDetailLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (state is BussinessDetailLoaded) {
  //         if (selectedIndex == -1) {
  //           return Column(
  //             children: [
  //               widget.desc == null
  //                   ? Padding(
  //                       padding: const EdgeInsets.all(10),
  //                       child: Column(
  //                         children: [
  //                           Card(
  //                             color: AppColors.productScreenBackground,
  //                             child: ExpansionTile(
  //                               title: TextWidget(
  //                                   text: 'माहिती ',
  //                                   fontSize: AppSizes.verticalPadding15px,
  //                                   fontWeight: FontWeight.bold),
  //                               backgroundColor:
  //                                   AppColors.productScreenBackground,
  //                               children: [
  //                                 Container(
  //                                   height: 300.h,
  //                                   color: AppColors.productScreenBackground,
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(10),
  //                                     child: Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           TextWidget(
  //                                             text: AppStrings.farmerMall,
  //                                             fontSize: 16.sp,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                           TextWidget(
  //                                             text: AppStrings
  //                                                 .experienceCenterDesc,
  //                                             fontSize: 13.sp,
  //                                           ),
  //                                         ]),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     )
  //                   : Expanded(
  //                       child: ListView.builder(
  //                       itemCount: state.bussinessDetail?.length ?? 0,
  //                       itemBuilder: (context, index) {
  //                         return Card(
  //                           color: AppColors.productScreenBackground,
  //                           child: ExpansionTile(
  //                               backgroundColor:
  //                                   AppColors.productScreenBackground,
  //                               title: TextWidget(
  //                                   text: 'माहिती ',
  //                                   fontSize: AppSizes.verticalPadding15px,
  //                                   fontWeight: FontWeight.bold),
  //                               children: [
  //                                 Container(
  //                                   height:
  //                                       MediaQuery.of(context).size.height.h,
  //                                   decoration: const BoxDecoration(
  //                                       color:
  //                                           AppColors.productScreenBackground),
  //                                   child: ListView.builder(
  //                                     itemCount:
  //                                         state.bussinessDetail?.length ?? 0,
  //                                     itemBuilder: (context, index) {
  //                                       return Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Padding(
  //                                             padding: const EdgeInsets.all(10),
  //                                             child: TextWidget(
  //                                                 text: widget.name.toString(),
  //                                                 fontSize: AppSizes
  //                                                     .verticalPadding15px,
  //                                                 fontWeight: FontWeight.bold),
  //                                           ),
  //                                           Padding(
  //                                             padding: const EdgeInsets.all(10),
  //                                             child: TextWidget(
  //                                                 text: widget.desc.toString()),
  //                                           ),
  //                                         ],
  //                                       );
  //                                     },
  //                                   ),
  //                                 )
  //                               ]),
  //                         );
  //                       },
  //                     )),
  //             ],
  //           );
  //         } else if (widget.serviceRequest == false || selectedIndex == 0) {
  //           return _productContainerWidget();
  //         } else {
  //           return const SizedBox();
  //         }
  //       } else if (state is BussinessDetailError) {
  //         return TextWidget(
  //           text: state.errorMessage,
  //         );
  //       } else {
  //         return const SizedBox();
  //       }
  //     },
  //   );
  // }

  // _shopServiceWidget() {
  //   return Container(
  //       height: 24.h,
  //       padding: EdgeInsets.only(left: 10),
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: myArray.length,
  //         itemBuilder: (context, index) {
  //           return Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               index == 0
  //                   ? Container(
  //                       padding: EdgeInsets.only(right: 20.w),
  //                       child: InkWell(
  //                         onTap: () {
  //                           setState(() {
  //                             selectedIndex = -1;
  //                             selectedCategory = null;
  //                             _searchController.clear();
  //                           });
  //                         },
  //                         child: TextWidget(
  //                           text: "माहिती ",
  //                           color: selectedIndex == -1
  //                               ? AppColors.textGreyColor
  //                               : AppColors.blackColor,
  //                           fontSize: 17.sp,
  //                         ),
  //                       ),
  //                     )
  //                   : const SizedBox(),
  //               Container(
  //                 padding: EdgeInsets.only(right: 20.w),
  //                 child: InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = index;
  //                         _searchController.clear();
  //                       });
  //                     },
  //                     child: widget.serviceRequest == true
  //                         ? TextWidget(
  //                             text: myArray[index],
  //                             color: selectedIndex == index
  //                                 ? AppColors.blackColor
  //                                 : AppColors.textGreyColor,
  //                             fontSize: 17.sp,
  //                           )
  //                         : const SizedBox()),
  //               ),
  //             ],
  //           );
  //         },
  //       ));
  // }
}
