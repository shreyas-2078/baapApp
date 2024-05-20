import 'package:baapapp/models/cart_model/get_cart_response_model.dart';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:baapapp/presentations/confirmation_screen/confirmation_screen.dart';
import 'package:baapapp/presentations/location_access_screen/location_access_screen.dart';
import 'package:baapapp/presentations/menu_detail_screen/menu_detail_screen.dart';
import 'package:baapapp/presentations/order_detail/order_detail_screen.dart';
import 'package:baapapp/presentations/payment_screen/payment_screen.dart';
import 'package:baapapp/presentations/payment_timer_screen/paymnet_timer_screen.dart';
import 'package:baapapp/presentations/product_detail_screen/product_detail_screen.dart';
import 'package:baapapp/presentations/product_screen/product_screen.dart';
import 'package:baapapp/presentations/profile_screen/profile_screen.dart';
import 'package:baapapp/presentations/cart/cart_screen.dart';
import 'package:go_router/go_router.dart';

import '../../models/product_response_model/product_response_model.dart';
import '../../presentations/home_screen/home_screen.dart';
import '../../presentations/menu_screen/menu_screen.dart';
import '../../presentations/list_sub_category/list_sub_category.dart';
import '../../presentations/sign_up/sign_up_Screen.dart';
import '../../presentations/splash_screen/splash_screen.dart';

class Routes {
  static String initial = "/";
  static String splashScreen = "/splash";
  static String homePageScreen = "/home-page";
  static String signupScreen = "/signup-page";
  static String listSubCategoryScreen = "/list-sub-category";
  static String menuScreen = "/menu";
  static String menuDetailScreen = "/menu-detail";
  static String profileScreen = "/profile";
  static String shoppingScreen = "/shopping";
  static String paymentScreen = "/payment";
  static String productDetailSCreen = "/product-detail";
  static String productScreen = "/product";
  static String confirmationScreen = "/confirmation";
  static String paymentTimerScreen = "/payment_timer_screen";
  static String orderDetailScreen = "/order_detail";
  static String locationAccessScreen = "/location_access";

  GoRouter get router => _goRouter;
  late final GoRouter _goRouter = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: homePageScreen,
        builder: (context, state) => const HomePageScreen(),
      ),
      GoRoute(
        path: signupScreen,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
          path: shoppingScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            final int? groupId = item['groupId'];
            final int? parentId = item['parentId'];
            return ShoppingScreen(groupId: groupId, parentId: parentId);
          }),
      GoRoute(
          path: paymentScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            int? groupId = item['groupId'];
            CartModel? cartModel = item['cartModel'] as CartModel;
            AddressModel? addressModel = item['addressModel'] as AddressModel;
            return PaymentScreen(
              groupId: groupId,
              addressModel: addressModel,
              cartModel: cartModel,
            );
          }),
      GoRoute(
          path: confirmationScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            int? orderId = item['orderId'];
            int? groupId = item['groupId'];
            return ConfirmationScreen(orderId: orderId, groupId: groupId);
          }),
      GoRoute(
        path: profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
          path: menuScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            int? initialIndex = item['index'];
            return MenuLists(initialIndex: initialIndex);
          }),
      GoRoute(
        path: orderDetailScreen,
        builder: (context, state) {
          var item = state.extra as Map<String, dynamic>;
          int? orderId = item["orderId"];
          String? dateTime = item["createdAt"];

          return OrderDetailScreen(orderId: orderId, dateTime: dateTime);
        },
      ),
      GoRoute(
          path: productScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            int? subCategoryId = item["subCategoryId"];
            int? categoryId = item["categoryId"];
            String? subCategoryName = item["subCategoryName"];
            int? groupId = item["groupId"];
            bool? serviceRequest = item["serviceRequest"];
            int? subGroupId = item["subGroupId"];
            int? businessId = item["businessId"];

            return ProductScreen(
              subCategoryId: subCategoryId,
              subCategoryName: subCategoryName,
              categoryId: categoryId,
              groupId: groupId,
              serviceRequest: serviceRequest,
              subGroupId: subGroupId,
              businessId: businessId,
            );
          }),
      GoRoute(
        path: profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: locationAccessScreen,
        builder: (context, state) => const LocationAccessScreen(),
      ),
      GoRoute(
          path: productDetailSCreen,
          builder: (context, state) {
            var data = state.extra as Map<String, dynamic>?;
            ProductList? item = data?['item'];
            int? groupId = data?['groupId'];
            return ProductDetailScreen(
              item: item,
              groupId: groupId,
            );
          }),
      GoRoute(
          path: menuDetailScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            int? servicerequestId = item["servicerequestId"];
            String? title = item["title"];
            String? dateTime = item["dateTime"];
            String? status = item["status"];
            int? handledById = item["handledById"];
            return MenuDetailScreen(
                servicerequestId: servicerequestId,
                title: title,
                dateTime: dateTime,
                status: status,
                handledById: handledById);
          }),
      GoRoute(
          path: listSubCategoryScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            String? categoryName = item["categoryName"];
            int? subCategoryId = item["subCategoryId"];
            return ListSubCategory(
              categoryName: categoryName,
              subCategoryId: subCategoryId,
            );
          }),
      GoRoute(
          path: paymentTimerScreen,
          builder: (context, state) {
            var item = state.extra as Map<String, dynamic>;
            String? id = item["id"];
            int? groupId = item['groupId'];
            return PaymentTimerScreen(id: id, groupId: groupId);
          }),
    ],
  );
}
