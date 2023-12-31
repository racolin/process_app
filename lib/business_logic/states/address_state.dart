import 'package:flutter/foundation.dart';
import 'package:process_app/exception/app_message.dart';

import '../../data/models/address_model.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> defaultAddresses;
  final List<AddressModel> otherAddresses;

  AddressLoaded({
    required this.defaultAddresses,
    required this.otherAddresses,
  });

  AddressLoaded copyWith({
    List<AddressModel>? defaultAddresses,
    List<AddressModel>? otherAddresses,
  }) {
    return AddressLoaded(
      defaultAddresses: defaultAddresses ?? this.defaultAddresses,
      otherAddresses: otherAddresses ?? this.otherAddresses,
    );
  }
}

class AddressFailure extends AddressState {
  final AppMessage message;

  AddressFailure({
    required this.message,
  });
}
