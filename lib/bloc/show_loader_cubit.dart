import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_loader_state.dart';

class ShowLoaderCubit extends Cubit<ShowLoaderState> {
  ShowLoaderCubit() : super(const ShowLoaderInitial(show: false));

  void enableLoader()=> emit(const ShowLoaderInitial(show: true));
  void disableLoader()=> emit(const ShowLoaderInitial(show: false));


}
