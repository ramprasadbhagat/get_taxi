import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'source_address_state.dart';

class SourceAddressCubit extends Cubit<AddressState> {
  SourceAddressCubit() : super(AddressInitialState());

  void editAddress({required String sourceAddress, String? destinationAddress}){
    print("sourceAddress : $sourceAddress");
    print("destinationAddress : $destinationAddress");
    emit(AddressEditState(sourceAddress: sourceAddress,destinationAddress: destinationAddress));
  }
}
