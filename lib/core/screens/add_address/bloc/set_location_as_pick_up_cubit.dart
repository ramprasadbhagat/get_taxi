import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_location_as_pick_up_state.dart';

class SetLocationAsPickUpCubit extends Cubit<SetLocationAsPickUpState> {
  SetLocationAsPickUpCubit() : super(const SetLocationAsPickUpInitial(isSet: false));

  void setLocationAsPickUpPoint(bool isSet)=> emit(SetLocationAsPickUpInitial(isSet: isSet));
}
