import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_password_state.dart';

class ShowPasswordCubit extends Cubit<ShowPasswordState> {
  ShowPasswordCubit() : super(const ShowPasswordInitial(show: false));

  void enable()=> emit(const ShowPasswordInitial(show: true));
  void disable()=> emit(const ShowPasswordInitial(show: false));
}
