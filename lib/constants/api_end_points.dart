import 'package:baapapp/models/api_base_model.dart';

class ApiEndPoints {
  ApiBaseModel? apiBaseModel;

  ApiEndPoints({this.apiBaseModel}) {
    if (apiBaseModel == null) {}
  }

  late String baseUrl = apiBaseModel?.commerceUrl ?? "";
  late String authBaseUrl = apiBaseModel?.authUrl ?? "";
  late String gatewayBaseUrl = apiBaseModel?.gatewayUrl ?? "";
  late String memberBaseUrl = apiBaseModel?.memberUrl ?? "";
  late String paymentBaseUrl = apiBaseModel?.paymentUrl ?? "";
  late String imageUploadBaseUrl = apiBaseModel?.imageUploadUrl ?? "";
  late String imageResizeBaseUrl = apiBaseModel?.imageResizeUrl ?? "";
  late String version = apiBaseModel?.version ?? "";

  late int groupId = apiBaseModel?.groupId ?? 0;
  late int experienceGroupId = apiBaseModel?.experienceGroupId ?? 0;
  late int roleId = apiBaseModel?.roleId ?? 0;

  late String getCategoryByGroupId = "category/all/getByGroupId/";
  late String getBussinessByCategoryId = "bussiness/all/getByGroupId/";
  late String getBussinessBySubGroupId = "/bussiness/all/getByGroupId/";
  late String getSubCategoryByCategoryId = "services/all/getByGroupId/";
  late String searchSubCategory = "analyticaldataGw/services/search/";
  late String searchLocalBussiness = "analyticaldataGw/bussiness/search/";
  late String getSubCategoryListBySubCategoryId = "services/all/getByGroupId/";
  late String serviceAction = "serviceaction/service/action";
  late String serviceActionByCustomer =
      "serviceaction/customer/service/request";
  late String imageUpload = 'signed-url';
  late String checkVersion = 'appVersion/gateway/getAppVersion';

  late String auth = "auth";
  late String authGateway = "authgw";
  late String commerceGateway = "commerce-gw/";

  late String sendOtp = "/sendotp";
  late String verifyOtp = "/validateOtp";
  late String saveCustomer = "commerce-gw/customer/save";

  late String serviceRequest = "servicerequest/group/";
  late String serviceresponse = "serviceresponse/group/";
  late String serviceResponse = "serviceaction/customer/service/responses";
  //profile
  late String refreshToken = "${gatewayBaseUrl}authgw/refresh-token";
  late String getCustomer = "customer/getByCustomerByUserId/";
  late String updateCustomer = "customer/updateByUserId/";
  late String updateCustomerUPI = "customer/accountDetails/";
  late String getCustomerUPI = "customer/upis/";
  late String updateAddress = "customer/updateAddress/";
  late String deleteAddress = "customer/deleteAddress/";

  //Product
  late String getGroup = "group/getByGroupId/";
  late String getProduct = "products/all/group/";
  late String cart = "cart/";
  late String cartdeleteAll = "cart/deleteAll/";
  late String getCartByUserId = "cart/getProductByUserId/";
  late String getDefaultAddress = "customer/getDefaultAddress";
  late String order = "products/order";
  late String getOrderDetailsByGroupId = "order/all/getByGroupId/";
  late String getOrderList = "order/order/group/";

  // Payment
  late String checkVPA = "vpa/check";
  late String collectVPA = "vpa/collect";
  late String checkPaymentStatus = "vpa/fetch/transaction/status";
}
           