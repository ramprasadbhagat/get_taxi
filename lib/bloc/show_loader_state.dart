part of 'show_loader_cubit.dart';

@immutable
abstract class ShowLoaderState {
  final bool show;
  const ShowLoaderState({required this.show});
}

class ShowLoaderInitial extends ShowLoaderState {
  const ShowLoaderInitial({required bool show}) : super(show: show);
}
