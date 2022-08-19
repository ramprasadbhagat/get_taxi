import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_map_padding_state.dart';

class BottomMapPaddingCubit extends Cubit<BottomMapPaddingState> {
  BottomMapPaddingCubit() : super(const BottomMapPaddingInitial(bottomPadding: 0));

  void changeBottomPadding(double x)=> emit(BottomMapPaddingInitial(bottomPadding: x));
}
