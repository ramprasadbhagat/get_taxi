import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_country_state.dart';

class UpdateCountryCubit extends Cubit<UpdateCountryState> {
  String country;
  UpdateCountryCubit({required this.country}) : super(UpdateCountryInitial(country: country));

  void updateCountryName(String country)=> emit(UpdateCountryInitial(country: country));
}
