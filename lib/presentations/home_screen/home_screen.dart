// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:baapapp/constants/app_images.dart';
import 'package:baapapp/constants/app_strings.dart';
import 'package:baapapp/logic/category/category_cubit.dart';
import 'package:baapapp/logic/image_upload/image_upload_cubit.dart';
import 'package:baapapp/logic/local_bussiness/local_bussiness_cubit.dart';
import 'package:baapapp/logic/profile_screen/profile_cubit.dart';
import 'package:baapapp/main.dart';
import 'package:baapapp/utils/api/debouncer.dart';
import 'package:baapapp/utils/app_utils/snackbar/snackbar.dart';
import 'package:baapapp/widgets/custom_button%20copy.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/event_textformfield_widget.dart';
import 'package:baapapp/widgets/sizedbox_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_enum.dart';
import '../../constants/app_sizes.dart';
import '../../logic/service_action/service_action_cubit.dart';
import '../../logic/sub_category/sub_category_cubit.dart';
import '../../utils/app_utils/app_utils.dart';
import '../../utils/keyboard_dismiss/keyboard_utils.dart';
import '../../utils/preferences/local_preferences.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/in_app_web_view_screen.dart';
import '../../widgets/local_bussiness_tile.dart';
import '../../widgets/sub_category_tile.dart';
import '../../widgets/text_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _checkForUpdate();

    context.read<CategoryCubit>().getCategory(context);
    context.read<ProfileCubit>().getCustomerData();
    context.read<SubCategoryCubit>().getSubCategory();
    context.read<LocalBussinessCubit>().getLocalBussies();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.initState();
  }

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  bool serviceRequest = false;
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debuncer = Debouncer(delay: const Duration(seconds: 1));

  void _handleTabChange() {
    if (_tabController.index == 0) {
      if (searchActive) {
        context
            .read<SubCategoryCubit>()
            .searchSubCategory(value: _searchController.text.trim());
      } else {
        context
            .read<SubCategoryCubit>()
            .getSubCategory(categoryId: selectedCategory);
      }
    } else if (_tabController.index == 1) {
      if (searchActive) {
        context
            .read<LocalBussinessCubit>()
            .searchLocalBussines(value: _searchController.text.trim());
      } else {
        context
            .read<LocalBussinessCubit>()
            .getLocalBussies(categoryId: selectedCategory);
      }
    }
  }

  Future<void> _checkForUpdate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime lastDialogTime = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('lastDialogTime') ?? 0);
      DateTime currentTime = DateTime.now();
      Duration difference = currentTime.difference(lastDialogTime);

      if (difference.inHours >= 24) {
        final response = await http.get(Uri.parse(
            '${apiEndpoints.gatewayBaseUrl}${apiEndpoints.checkVersion}'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          var latestVersion = data['version'];
          if (latestVersion != apiEndpoints.version) {
            _showUpdateDialog();

            // Update the last time the dialog was shown
            prefs.setInt('lastDialogTime', currentTime.millisecondsSinceEpoch);
          }
        } else {
          // Handle error response
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget(
            text: 'अपडेट उपलब्ध आहे',
            fontSize: 19.sp,
          ),
          content: TextWidget(
            text: 'आमच्या अँप चे नवीन अपडेट आले आहे. कृपया अपडेट करा ',
            fontSize: 14.sp,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'नंतर',
                fontSize: 16.sp,
              ),
            ),
            TextButton(
              onPressed: () {
                _launchPlayStore();
              },
              child: TextWidget(
                text: 'अपडेट करा',
                fontSize: 16.sp,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchPlayStore() async {
    const String playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.baapcompany.baapapp";
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(playStoreUrl)) {
        // ignore: deprecated_member_use
        await launch(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    } catch (e) {
      SnackBarWidget.showSnackbar(
        context,
        'Play store open झालं नाही',
        color: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int selectedIndex = -1;
  int? selectedCategory;
  bool searchActive = false;
  late TabController _tabController;
  DateTime? _lastBackPressed;

  String latGetStorage = GetStorage().read('latitude') ?? "00.00000";
  String longGetStorage = GetStorage().read('longitude') ?? "00.00000";
  String? locationName = LocalStorageUtils.getLocationName();
  String? locationPin = LocalStorageUtils.getlocationPin();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          DateTime currentTime = DateTime.now();
          if (_lastBackPressed == null ||
              currentTime.difference(_lastBackPressed!) >
                  const Duration(seconds: 2)) {
            _lastBackPressed = currentTime;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: TextWidget(
                  text: 'मागील बटन परत क्लिक करा',
                ),
              ),
            );
            return false;
          } else {
            await SystemNavigator.pop();
            return false;
          }
        },
        child: SafeArea(
            child: GestureDetector(
          onTap: () {
            KeyBoardUtils.hideKeyBoard(context);
          },
          child: Stack(
            children: [
              DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          pinned: true,
                          stretch: true,
                          automaticallyImplyLeading: false,
                          expandedHeight: 300.h,
                          collapsedHeight: 215.h,
                          toolbarHeight: 100.h,
                          backgroundColor: AppColors.backgroundLight,
                          systemOverlayStyle: systemOverLayStyle,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            collapseMode: CollapseMode.pin,
                            titlePadding: EdgeInsets.only(
                              top: AppSizes.verticalPadding15px,
                              left: AppSizes.horizontalPadding15px,
                              bottom: 10.h,
                            ),
                            title: SizedBox(
                              height: 197.h,
                              child: _informationContainer(),
                            ),
                            background: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300.h,
                              color: AppColors.backgroundLight,
                              padding: EdgeInsets.only(
                                left: AppSizes.horizontalPadding15px,
                                top: AppSizes.verticalPadding15px,
                                right: AppSizes.horizontalPadding15px,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _personalInfoContainer(),
                                  // SizedBoxWidget(
                                  //   height: 10.h,
                                  // ),
                                  const Divider(
                                    color: AppColors.textGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            color: AppColors.backgroundDark,
                            padding: EdgeInsets.only(
                                top: AppSizes.verticalPadding10px),
                            child: _categoryWidget(),
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      color: AppColors.backgroundDark,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _subCategoryWidget(),
                          _localBussineWidget(),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.only(
                      left: AppSizes.horizontalPadding15px,
                      bottom: AppSizes.horizontalPadding15px,
                      right: AppSizes.horizontalPadding15px,
                    ),
                    color: AppColors.backgroundDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: AppColors.whiteColor,
                          dividerColor: AppColors.textGreyColor,
                          unselectedLabelColor: AppColors.textGreyColor,
                          indicatorColor: AppColors.textColor,
                          tabs: [
                            Tab(
                              child: TextWidget(
                                text: 'सेवा',
                                fontSize: 17.sp,
                              ),
                            ),
                            Tab(
                              child: TextWidget(
                                text: 'दुकान',
                                fontSize: 17.sp,
                              ),
                            ),
                          ],
                        ),
                        const SizedBoxWidget(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const InAppWebViewVidget(
                                        categoryName: 'Terms & Conditions',
                                        url:
                                            'https://content.baapmarket.com/policy');
                                  },
                                );
                              },
                              child: TextWidget(
                                text: "Disclaimer ",
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  : const SizedBox(),
              // context.watch<ImageUploadCubit>().state is ImageUploadLoading
              //     ? BackdropFilter(
              //         filter: ImageFilter.blur(
              //           sigmaX: 3,
              //           sigmaY: 3,
              //         ),
              //         child: Container(
              //           color: Colors.white.withOpacity(0.5),
              //           child: Center(
              //             child: Lottie.asset(
              //               AppImages.loadingAnimation,
              //             ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox(),
            ],
          ),
        )));
  }

  _getFirstCharacter(String? name) {
    String? firstString = name?.split(" ").first;
    String firstCharacters = "";
    if (firstString != null) {
      firstCharacters = firstString[0];
    }
    return firstCharacters;
  }

  _personalInfoContainer() {
    // String latTruncated = latGetStorage.substring(0, 6);
    // String longTruncated = longGetStorage.substring(0, 6);
    return BlocBuilder<ProfileCubit, ProfileState>(builder: ((context, state) {
      var name = state.customerData?.name;
      String firstInitial = _getFirstCharacter(name);
      if (state is ProfileLoading) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: AppStrings.welcome,
                    color: Color(0xff707070),
                  ),
                  TextWidget(
                    text: 'BAAP APP',
                    color: const Color(0xffC9C9C9),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  const TextWidget(
                    text: "",
                    color: Color(0xff9F9F9F),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                var user = await LocalStorageUtils.fetchToken();
                if (user?.isNotEmpty ?? false) {
                  context.push(Routes.profileScreen);
                } else {
                  context.push(Routes.signupScreen);
                }
              },
              child: CircleAvatar(
                backgroundColor: const Color(0XFFC9C9C9).withOpacity(0.3),
                child: TextWidget(
                  text: "B",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0XFF3C3D4A),
                ),
              ),
            )
          ],
        );
      }

      return state.customerData != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: 'नमस्कार',
                        color: Color(0xff707070),
                      ),
                      TextWidget(
                        text: state.customerData?.name ?? '',
                        color: const Color(0xffC9C9C9),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: state.customerData?.location,
                            color: const Color(0xff9F9F9F),
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const TextWidget(
                            text: "",
                            color: Color(0xff9F9F9F),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(Routes.profileScreen);
                  },
                  child: state.customerData?.imageUrl == null
                      ? CircleAvatar(
                          backgroundColor:
                              const Color(0XFFC9C9C9).withOpacity(0.3),
                          child: TextWidget(
                            text: firstInitial,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffC9C9C9),
                          ),
                        )
                      : Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  state.customerData?.imageUrl ?? ""),
                            ),
                          ),
                        ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: AppStrings.welcome,
                        color: Color(0xff707070),
                      ),
                      TextWidget(
                        text: 'BAAP APP',
                        color: const Color(0xffC9C9C9),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      const TextWidget(
                        text: "",
                        color: Color(0xff9F9F9F),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var user = await LocalStorageUtils.fetchToken();
                    if (user?.isNotEmpty ?? false) {
                      context.push(Routes.profileScreen);
                    } else {
                      context.push(Routes.signupScreen);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0XFFC9C9C9).withOpacity(0.3),
                    child: TextWidget(
                      text: "B",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0XFF3C3D4A),
                    ),
                  ),
                )
              ],
            );
    }));
  }

  _informationContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _homeContainer(context),
        Padding(
          padding: EdgeInsets.only(right: 13.w),
          child: RotatedBox(
            quarterTurns: 1,
            child: TextWidget(
              text: 'EMPOWERING VILLAGES',
              fontSize: 12.sp,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: const Color(0xffC9C9C9).withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }

  _homeContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppImages.homeSelectedIcon,
                height: 19.h,
                width: 19.w,
              ),
              const SizedBoxWidget(
                width: 5,
              ),
              TextWidget(
                text: 'प्लॅटफॉर्म',
                color: const Color(0XFFC8E676),
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),
              const SizedBoxWidget(
                width: 18,
              ),
              InkWell(
                onTap: () async {
                  var user = await LocalStorageUtils.fetchToken();
                  if (user?.isNotEmpty ?? false) {
                    context.push(Routes.menuScreen, extra: {"index": 0});
                  } else {
                    context.push(Routes.signupScreen);
                  }
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.menuIcon,
                      height: 19.h,
                      width: 19.w,
                      // ignore: deprecated_member_use
                      color: AppColors.textGreyColor,
                    ),
                    const SizedBoxWidget(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'ऑर्डर',
                      color: AppColors.textColor,
                      fontSize: 17.sp,
                    ),
                  ],
                ),
              ),
              const SizedBoxWidget(width: 18),
              InkWell(
                onTap: () async {
                  var user = await LocalStorageUtils.fetchToken();
                  if (user?.isNotEmpty ?? false) {
                    context.push(Routes.productScreen, extra: {
                      "groupId": apiEndpoints.experienceGroupId,
                      "serviceRequest": true,
                    });
                  } else {
                    context.push(Routes.signupScreen);
                  }
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.productIcon,
                      height: 19.h,
                      width: 19.w,
                    ),
                    const SizedBoxWidget(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'मार्केट',
                      color: AppColors.textColor,
                      fontSize: 17.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // DottedLine(),
          SizedBoxWidget(height: 13.h),
          TextWidget(
            text: AppStrings.youwantText,
            color: const Color(0XFFC8E676),
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBoxWidget(height: 12.h),
          const TextWidget(
            text: AppStrings.justtapText,
            color: AppColors.textColor,
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
          ),
          const TextWidget(
            text: AppStrings.teamhelp,
            color: AppColors.textColor,
            textOverflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
          ),
          SizedBoxWidget(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EventTextformFieldWidget(
                width: 260.w,
                controller: _searchController,
                onOutSideTap: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                hintText: "काही पण शोधा.",
                fontSize: 18.sp,
                hintTextColor: Colors.white.withOpacity(0.3),
                backgroundColor: AppColors.textformFieldColor.withOpacity(0.2),
                isSuffixIconShow: true,
                onChanged: (value) {
                  _debuncer.debounce(() {
                    selectedIndex = -1;
                    selectedCategory = null;
                    setState(() {});
                    if (value.length > 2) {
                      searchActive = true;
                      context
                          .read<SubCategoryCubit>()
                          .searchSubCategory(value: value.trim());
                      context
                          .read<LocalBussinessCubit>()
                          .searchLocalBussines(value: value.trim());
                    } else if (value.isEmpty) {
                      searchActive = false;
                      context.read<SubCategoryCubit>().getSubCategory();
                      context.read<LocalBussinessCubit>().getLocalBussies();
                    } else {}
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: InkWell(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 35.h,
                    color: AppColors.editTextformFieldColor,
                  ),
                  onTap: () async {
                    var user = await LocalStorageUtils.fetchToken();
                    if (user?.isNotEmpty ?? false) {
                      int? userId = LocalStorageUtils.tokenResponseModel.userId;
                      _showButtomModelSheet(context,
                          userId: userId, isCamera: true);
                    } else {
                      context.push(Routes.signupScreen);
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _categoryWidget() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SizedBox();
        }
        return Container(
          color: AppColors.backgroundDark,
          height: 24.h,
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding15px,
          ),
          margin: EdgeInsets.only(
            bottom: AppSizes.verticalPadding10px,
          ),
          child: SizedBox(
            width: 200.w,
            child: SizedBox(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoryModel?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = state.categoryModel?[index];
                    // selectedCategory = state.categoryModel?.first.categoryId;
                    return Row(
                      children: [
                        index == 0
                            ? Container(
                                padding: EdgeInsets.only(right: 20.w, top: 1.h),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = -1;
                                      selectedCategory = null;
                                    });
                                    if (_tabController.index == 0) {
                                      if (searchActive) {
                                        context
                                            .read<SubCategoryCubit>()
                                            .searchSubCategory(
                                                value: _searchController.text
                                                    .trim());
                                      } else {
                                        context
                                            .read<SubCategoryCubit>()
                                            .getSubCategory();
                                      }
                                    } else if (_tabController.index == 1) {
                                      if (searchActive) {
                                        context
                                            .read<LocalBussinessCubit>()
                                            .searchLocalBussines(
                                                value: _searchController.text
                                                    .trim());
                                      } else {
                                        context
                                            .read<LocalBussinessCubit>()
                                            .getLocalBussies();
                                      }
                                    }
                                  },
                                  child: TextWidget(
                                    text: "सर्व",
                                    color: selectedIndex == -1
                                        ? const Color(0XFFC8E676)
                                        : AppColors.textGreyColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          padding: EdgeInsets.only(right: 20.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedCategory = item?.categoryId;
                              });
                              // if (_tabController.index == 0) {
                              context
                                  .read<SubCategoryCubit>()
                                  .getSubCategory(categoryId: item?.categoryId);
                              // } else if (_tabController.index == 1) {
                              context
                                  .read<LocalBussinessCubit>()
                                  .getLocalBussies(
                                      categoryId: item?.categoryId);
                              // }
                            },
                            child: TextWidget(
                              text: state.categoryModel?[index].name,
                              color: selectedIndex == index
                                  ? const Color(0XFFC8E676)
                                  : AppColors.textGreyColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  _subCategoryWidget() {
    return BlocBuilder<SubCategoryCubit, SubCategoryState>(
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return SizedBox(
            height: 20.h,
            width: 30.w,
            child: Lottie.asset(AppImages.loadingWhiteAnimation),
          );
        }
        if (state is SubCategoryError) {
          return Center(
            child: TextWidget(
              text: "काही तरी चुकल.",
              fontSize: 15.sp,
              color: Colors.white,
            ),
          );
        }
        if (state.subCategoryModel?.isEmpty ?? false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LocalBussinessCubit, LocalBussinessState>(
                  builder: (context, state) {
                    if (state.localBussiness?.isNotEmpty ?? false) {
                      return InkWell(
                        onTap: () {
                          _tabController.animateTo(1);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: TextWidget(
                                text:
                                    'या सेवेच्या संदर्भात ${state.localBussiness?.length} दुकाने मिळाली',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0XFFC8E676),
                              ),
                            ),
                            Lottie.asset(
                              AppImages.rightArrowAnimation,
                              height: 50.h,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state.localBussiness?.isEmpty ?? false) {
                      return TextWidget(
                        text: "माहिती मिळाली नाही.",
                        fontSize: 15.sp,
                        color: Colors.white,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          );
        }
        if (state.subCategoryModel?.isNotEmpty ?? false) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding15px,
              right: AppSizes.horizontalPadding15px,
              top: AppSizes.verticalPadding15px,
              bottom: 0,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10.w,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10.h,
              ),
              padding: EdgeInsets.zero,
              itemCount: state.subCategoryModel?.length,
              itemBuilder: (context, index) {
                return SubCategoryListTile(
                  onPressed: () async {
                    var user = await LocalStorageUtils.fetchToken();
                    if (user?.isEmpty ?? false) {
                      context.push(Routes.signupScreen);
                    } else {
                      var uId = LocalStorageUtils.tokenResponseModel.userId;
                      if (state.subCategoryModel?[index].action ==
                          ClickAction.whatsapp.name) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(30),
                                child: AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: const Color(0XFFEFEFEF),
                                  elevation: 16,
                                  content: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextWidget(
                                          text:
                                              'तुम्हाला खरंच ${state.subCategoryModel?[index].name} पाहिजे आहे का?',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0XFF5C3F3F),
                                        ),
                                        const SizedBoxWidget(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<ServiceActionCubit>()
                                                    .serviceAction(
                                                      subCategoryId: state
                                                          .subCategoryModel?[
                                                              index]
                                                          .subcategoryId,
                                                      userId: uId,
                                                      categoryId: state
                                                          .subCategoryModel?[
                                                              index]
                                                          .categoryId,
                                                    );
                                                Navigator.pop(context);
                                                FocusNode().unfocus();
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF707070),
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                                child: Center(
                                                  child: TextWidget(
                                                    text: 'हो',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp,
                                                    color:
                                                        const Color(0XFF5C3F3F),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBoxWidget(width: 10),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                FocusNode().unfocus();
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF707070),
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                                child: Center(
                                                  child: TextWidget(
                                                    text: 'नाही',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.sp,
                                                    color:
                                                        const Color(0XFF5C3F3F),
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
                      } else if (state.subCategoryModel?[index].action ==
                          ClickAction.webpage.name) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InAppWebViewVidget(
                              categoryName: state.subCategoryModel?[index].name,
                              url:
                                  "${state.subCategoryModel?[index].webpageUrl}?groupId=${apiEndpoints.experienceGroupId}&userId=$uId&categoryId=${state.subCategoryModel?[index].categoryId}&subcategoryId=${state.subCategoryModel?[index].subcategoryId}&lat=$latGetStorage&lon=$longGetStorage&locationName=$locationName&locationPin=$locationPin",
                            );
                          },
                        );
                      } else if (state.subCategoryModel?[index].action ==
                          ClickAction.document.name) {
                        _showButtomModelSheet(
                          context,
                          isCamera: false,
                          subCategoryId:
                              state.subCategoryModel?[index].subcategoryId,
                          userId: uId,
                          categoryId: state.subCategoryModel?[index].categoryId,
                        );
                      } else if (state.subCategoryModel?[index].action ==
                          ClickAction.list.name) {
                        context.push(Routes.listSubCategoryScreen, extra: {
                          "categoryName":
                              state.subCategoryModel?[index].name ?? "",
                          "subCategoryId":
                              state.subCategoryModel?[index].subcategoryId,
                        });
                      } else if (state.subCategoryModel?[index].action ==
                          ClickAction.productList.name) {
                        context.push(Routes.productScreen, extra: {
                          "serviceRequest": true,
                          "subCategoryId":
                              state.subCategoryModel?[index].subcategoryId,
                          'subCategoryName':
                              state.subCategoryModel?[index].name,
                          "categoryId":
                              state.subCategoryModel?[index].categoryId,
                          "groupId": apiEndpoints.experienceGroupId,
                          "subGroupId":
                              state.subCategoryModel?[index].subGroupId,
                        });
                      }
                    }
                  },
                  item: state.subCategoryModel?[index],
                );
              },
            ),
          );
        }
        return SizedBox(
          height: 20.h,
          width: 30.w,
          child: Lottie.asset(AppImages.loadingWhiteAnimation),
        );
      },
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

  _localBussineWidget() {
    return BlocBuilder<LocalBussinessCubit, LocalBussinessState>(
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return SizedBox(
            height: 20.h,
            width: 30.w,
            child: Lottie.asset(AppImages.loadingWhiteAnimation),
          );
        }
        if (state is LocalBussinessError) {
          return Center(
            child: TextWidget(
              text: "काही तरी चुकल.",
              fontSize: 15.sp,
              color: Colors.white,
            ),
          );
        }
        if (state.localBussiness?.isEmpty ?? false) {
          return Center(
            child: BlocBuilder<SubCategoryCubit, SubCategoryState>(
              builder: (context, state) {
                if (state.subCategoryModel?.isNotEmpty ?? false) {
                  return InkWell(
                    onTap: () {
                      _tabController.animateTo(0);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: Lottie.asset(
                            AppImages.rightArrowAnimation,
                            height: 50.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: TextWidget(
                            text:
                                'या सेवेच्या संदर्भात ${state.subCategoryModel?.length} सेवा मिळाली',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFFC8E676),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state.subCategoryModel?.isEmpty ?? false) {
                  return TextWidget(
                    text: "माहिती मिळाली नाही.",
                    fontSize: 15.sp,
                    color: Colors.white,
                  );
                }
                return const SizedBox();
              },
            ),
          );
        }
        if (state.localBussiness?.isNotEmpty ?? false) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppSizes.horizontalPadding15px,
              right: AppSizes.horizontalPadding15px,
              top: AppSizes.verticalPadding15px,
            ),
            child: SizedBox(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 140,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10.h,
                ),
                padding: EdgeInsets.zero,
                itemCount: state.localBussiness?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return LocalBussinessListTile(
                    onPressed: () async {
                      var user = await LocalStorageUtils.fetchToken();
                      if (user?.isEmpty ?? false) {
                        context.push(Routes.signupScreen);
                      } else {
                        context.push(Routes.productScreen, extra: {
                          "subGroupId": state.localBussiness?[index].subGroupId,
                          "groupId": state.localBussiness?[index].groupId,
                          "categoryId": state.localBussiness?[index].categoryId,
                          "businessId": state.localBussiness?[index].businessId,
                        });
                      }
                    },
                    item: state.localBussiness?[index],
                  );
                },
              ),
            ),
          );
        }
        return SizedBox(
          height: 20.h,
          width: 30.w,
          child: Lottie.asset(AppImages.loadingWhiteAnimation),
        );
      },
    );
  }
}
