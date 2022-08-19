part of 'show_password_cubit.dart';

@immutable
abstract class ShowPasswordState {
  final bool show;
  const ShowPasswordState({required this.show});
}

class ShowPasswordInitial extends ShowPasswordState {
  const ShowPasswordInitial({required bool show}) : super(show: show);
}
