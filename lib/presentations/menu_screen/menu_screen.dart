import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/logic/menu_logic/menu_cubit.dart';
import 'package:baapapp/logic/order_list/order_list_cubit.dart';
import 'package:baapapp/utils/routes/routes.dart';
import 'package:baapapp/widgets/custom_circular_progress_indicator.dart';
import 'package:baapapp/widgets/menu_list_list_tile.dart';
import 'package:baapapp/widgets/order_list_tile.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../utils/app_utils/app_utils.dart';

// ignore: must_be_immutable
class MenuLists extends StatefulWidget {
  MenuLists({super.key, this.initialIndex});

  int? initialIndex;

  @override
  State<MenuLists> createState() => _MenuListsState();
}

class _MenuListsState extends State<MenuLists>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    context.read<ServiceRequestCubit>().getServiceRequests();
    context.read<OrderListCubit>().getOrderList();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialIndex ?? 0);
    _tabController.addListener(_handleTabChange);
    // _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  void _handleTabChange() {}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: widget.initialIndex ?? 0,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: systemOverLayStyle,
            surfaceTintColor: Colors.white10,
            iconTheme: const IconThemeData(
              color: AppColors.whiteColor,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.push(Routes.homePageScreen);
              },
            ),
            backgroundColor: AppColors.backgroundDark,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextWidget(
                text: 'ऑर्डर आणि विनंत्या',
                color: AppColors.textYellowColor,
                fontSize: 20.sp,
              ),
            ),
            bottom: TabBar(
              // indicatorPadding: EdgeInsets.only(top: 10),
              controller: _tabController,
              labelColor: AppColors.whiteColor,
              dividerColor: AppColors.textGreyColor,
              unselectedLabelColor: AppColors.textGreyColor,
              indicatorColor: AppColors.textColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    margin: EdgeInsets.only(bottom: 3.h),
                    child: Center(
                      child: TextWidget(
                        text: 'विनंत्या',
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    margin: EdgeInsets.only(bottom: 3.h),
                    child: Center(
                      child: TextWidget(
                        text: 'ऑर्डर',
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.backgroundDark,
          body: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
            child: TabBarView(
              controller: _tabController,
              children: [
                _menuWidget(),
                _orderWidget(),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuWidget() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
            builder: (context, state) {
              if (state is ServiceRequestUpdateSuccess) {
                context.read<ServiceRequestCubit>().getServiceRequests();
              } else if (state is ServiceRequestLoading) {
                return const Center(
                  child: CustomCircularProgressIndidator(),
                );
              } else if (state is ServiceRequestError) {
                return Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: TextWidget(
                    text: state.error ?? "तुम्ही कोणतीही विनंती केलेली नाही ",
                    color: AppColors.whiteColor,
                    fontSize: 15.sp,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: ListView.builder(
                  itemCount: state.menuModel?.length ?? 0,
                  itemBuilder: (context, index) {
                    int? handleById = state.menuModel?[index].handledById;
                    String date = state.menuModel?[index].dateTime ?? '';
                    DateTime dateTime = DateTime.parse(date);
                    // initializeDateFormatting();
                    DateTime localDateTime = dateTime.toLocal();
                    String formattedDate = DateFormat('dd MMM yyyy   hh:mm a')
                        .format(localDateTime);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: InkWell(
                        onTap: () {
                          // print(handleById);

                          context.push(Routes.menuDetailScreen, extra: {
                            "servicerequestId":
                                state.menuModel?[index].servicerequestId,
                            "title": state.menuModel?[index].title,
                            "status": state.menuModel?[index].status,
                            "dateTime": formattedDate,
                            "handledById": handleById
                          });
                        },
                        child: MenuListTile(
                          menuModel: state.menuModel?[index],
                          dateTime: formattedDate,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _orderWidget() {
    return Column(
      children: [
        SizedBox(
          height: 7.h,
        ),
        // OrderListTile(),
        Expanded(child: BlocBuilder<OrderListCubit, OrderListState>(
            builder: (context, state) {
          if (state is OrderListLoading) {
            return const Center(
              child: CustomCircularProgressIndidator(),
            );
          } else if (state.orderModel == null ||
              (state.orderModel?.isEmpty ?? false)) {
            Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: TextWidget(
                text: "तुम्ही कोणतीही ऑर्डर केलेली नाही ",
                color: AppColors.textGreyColor,
                // Colors.grey,
                fontSize: 15.sp,
              ),
            );
          } else if (state is OrderListError) {
            return Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: TextWidget(
                text: state.error ?? "तुम्ही कोणतीही ऑर्डर केलेली नाही ",
                color: AppColors.textGreyColor,
                fontSize: 15.sp,
              ),
            );
          }
          return state.orderModel == null ||
                  (state.orderModel?.isEmpty ?? false)
              ? Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: TextWidget(
                    text: "तुम्ही कोणतीही ऑर्डर केलेली नाही",
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                )
              : ListView.builder(
                  itemCount: state.orderModel?.length ?? 0,
                  itemBuilder: (context, index) {
                    var orderId = state.orderModel?[index].orderId ?? 0;
                    String date =
                        state.orderModel?[index].orderDate.toString() ?? '';
                    DateTime dateTime = DateTime.parse(date);
                    DateTime localDateTime = dateTime.toLocal();
                    String formattedDate = DateFormat('dd MMM yyyy   hh:mm a')
                        .format(localDateTime);
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.push(Routes.orderDetailScreen, extra: {
                            "orderId": orderId,
                            "formattedDateTime": formattedDate,
                          });
                        },
                        child: OrderListTile(
                          orderData: state.orderModel?[index],
                          formattedDateTime: formattedDate,
                        ),
                      ),
                    );
                  });
        })),
      ],
    );
  }
}
