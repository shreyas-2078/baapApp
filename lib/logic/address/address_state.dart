part of 'address_cubit.dart';

abstract class DefaultAddressState {
  AddressModel? addressModel;
  DefaultAddressState({this.addressModel});
}

class DefaultAddressInitial extends DefaultAddressState {
  DefaultAddressInitial({super.addressModel});
}

class DefaultAddressLoading extends DefaultAddressState {
  DefaultAddressLoading({super.addressModel});
}

class DefaultAddressError extends DefaultAddressState {
  final String? error;
  DefaultAddressError({this.error, super.addressModel});
}

class DefaultAddressLoaded extends DefaultAddressState {
  DefaultAddressLoaded({super.addressModel});
}
