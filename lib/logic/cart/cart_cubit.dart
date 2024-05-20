import 'package:baapapp/models/cart_model/get_cart_response_model.dart';
import 'package:baapapp/repositories/cart_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:bloc/bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo = CartRepo();
  var userId = LocalStorageUtils.tokenResponseModel.userId ?? 0;
  CartCubit() : super(CartInitial(CartResponseModel()));

  void addToCart(int? productId, int? groupId, int? parentGroupId) async {
    emit(CartLoading(CartResponseModel()));
    var data = {
      "groupId": groupId,
      "parentGroupId": parentGroupId,
      "userId": userId,
      "products": [
        {"productcode": productId, "quantity": 1}
      ]
    };
    var response = await _cartRepo.addToCart(data);
    response.fold((error) {
      emit(CartError(CartResponseModel(), error.message));
    }, (data) {
      emit(CartAddSuccess(CartResponseModel()));
      // getCart();
    });
  }

  void getCart({
    int? groupId,
  }) async {
    emit(CartLoading(CartResponseModel()));
    var response = await _cartRepo.getCartByGroupIdAndUserId(
      groupId: groupId,
      userId: userId,
    );
    response.fold((error) {
      emit(CartError(CartResponseModel(), error.message));
    }, (data) {
      emit(CartLoaded(data));
    });
  }

  void updateCartProductById(
      int? groupId, int? productCode, int? quantity) async {
    emit(CartLoading(CartResponseModel()));
    var userId = LocalStorageUtils.tokenResponseModel.userId;
    var data = {"quantity": quantity};
    var response =
        await _cartRepo.updateCartProduct(groupId, data, userId, productCode);
    response.fold((error) {
      emit(CartError(CartResponseModel(), error.message));
    }, (data) {
      // getCart();
      emit(CartAddSuccess(CartResponseModel()));
    });
  }

  void deleteCartProductById(
      {int? groupId, int? cartId, int? productId}) async {
    emit(CartLoading(CartResponseModel()));
    var response = await _cartRepo.deleteCartByProductId(
      groupId: groupId,
      cartId: cartId,
      productCode: productId,
    );
    response.fold((error) {
      emit(CartError(CartResponseModel(), error.message));
    }, (data) {
      // getCart();
      emit(CartAddSuccess(CartResponseModel()));
    });
  }
}
