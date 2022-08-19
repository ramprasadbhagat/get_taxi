part of 'set_location_as_pick_up_cubit.dart';

@immutable
abstract class SetLocationAsPickUpState {
  final bool isSet;
  const SetLocationAsPickUpState({required this.isSet});
}

class SetLocationAsPickUpInitial extends SetLocationAsPickUpState {
  const SetLocationAsPickUpInitial({required bool isSet}) : super(isSet: isSet);
}
