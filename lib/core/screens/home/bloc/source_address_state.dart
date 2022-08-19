part of 'source_address_cubit.dart';

@immutable
abstract class AddressState {
}

class AddressInitialState extends AddressState {
}

class AddressEditState extends AddressState {
  final String sourceAddress;
  final String? destinationAddress;
  AddressEditState({required this.sourceAddress,this.destinationAddress});
}