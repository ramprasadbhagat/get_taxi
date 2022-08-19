part of 'update_country_cubit.dart';

@immutable
abstract class UpdateCountryState {
  final String country;
  const UpdateCountryState({required this.country});
}

class UpdateCountryInitial extends UpdateCountryState {
  const UpdateCountryInitial({required String country}) : super(country: country);
}
