import 'package:baapapp/logic/bussiness_detail/bussiness_detail_cubit.dart';
import 'package:baapapp/logic/cart/cart_cubit.dart';
import 'package:baapapp/logic/common/dropdown_widget2.dart';
import 'package:baapapp/logic/common/dropdown_widget_cubit_address.dart';
import 'package:baapapp/logic/common/radio/radio__button_cubit.dart';
import 'package:baapapp/logic/common/slider_cubit.dart';
import 'package:baapapp/logic/group_data/group_data_cubit.dart';
import 'package:baapapp/logic/location_screen/location_cubit.dart';
import 'package:baapapp/logic/menu_detail_logic/menu_detail_cubit.dart';
import 'package:baapapp/logic/order_list/order_list_cubit.dart';
import 'package:baapapp/logic/payment_service/check_payment/check_payment_cubit.dart';
import 'package:baapapp/logic/payment_service/check_vpa/check_vpa_cubit.dart';
import 'package:baapapp/logic/payment_service/collect_vpa/collect_vpa_cubit.dart';
import 'package:baapapp/logic/payment_service/get_upi_list/get_upi_list_cubit.dart';
import 'package:baapapp/logic/product_category/product_category_cubit.dart';
import 'package:baapapp/logic/product_screen/product_screen_cubit.dart';
import 'package:baapapp/logic/profile_screen/profile_cubit.dart';
import 'package:baapapp/logic/sub_category_list/sub_category_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';

import '../logic/address/address_cubit.dart';
import '../logic/category/category_cubit.dart';
import '../logic/common/checkbox_widget.dart';
import '../logic/common/dropdown_widget_cubit.dart';
import '../logic/image_upload/image_upload_cubit.dart';
import '../logic/local_bussiness/local_bussiness_cubit.dart';
import '../logic/menu_logic/menu_cubit.dart';
import '../logic/order/order_confirmaion/order_confirmaion_cubit.dart';
import '../logic/order/place_order/place_order_cubit.dart';
import '../logic/service_action/service_action_cubit.dart';
import '../logic/signup_logic/signup_screen_cubit.dart';
import '../logic/sub_category/sub_category_cubit.dart';

List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (context) => CategoryCubit()),
  BlocProvider(create: (context) => SubCategoryCubit()),
  BlocProvider(create: (context) => LocalBussinessCubit()),
  BlocProvider(create: (context) => ServiceActionCubit()),
  BlocProvider(create: (context) => SignUpCubit()),
  BlocProvider(create: (context) => ImageUploadCubit()),
  BlocProvider(create: (context) => ProfileCubit()),
  BlocProvider(create: (context) => SubCategoryListCubit()),
  BlocProvider(create: (context) => ServiceRequestCubit()),
  BlocProvider(create: (context) => ServiceRequestDetailCubit()),
  BlocProvider(create: (context) => ProductListCubit()),
  BlocProvider(create: (context) => DropdownButtonCubit()),
  BlocProvider(create: (context) => CheckboxCubit()),
  BlocProvider(create: (context) => CartCubit()),
  BlocProvider(create: (context) => DefaultAddressCubit()),
  BlocProvider(create: (context) => PlaceOrderCubit()),
  BlocProvider(create: (context) => OrderDetailsCubit()),
  BlocProvider(create: (context) => OrderListCubit()),
  BlocProvider(create: (context) => BussinessDetailCubit()),
  BlocProvider(create: (context) => CheckVPACubit()),
  BlocProvider(create: (context) => CollectVPACubit()),
  BlocProvider(create: (context) => CheckPaymentStatusCubit()),
  BlocProvider(create: (context) => DropdownAddressCubit()),
  BlocProvider(create: (context) => DropdownButtonCubit2()),
  BlocProvider(create: (context) => GroupDataCubit()),
  BlocProvider(create: (context) => SliderCubit()),
  BlocProvider(create: (context) => RadioButtonCubit()),
  BlocProvider(create: (context) => ProductCategoryCubit()),
  BlocProvider(create: (context) => GetUPIListCubit()),
  BlocProvider(create: (context) => LocationCubit()),
];
