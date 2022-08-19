import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SourceAddressRepository{
  Placemark? placeMark;
  Position? position;

  void setLocation({required Placemark placeMark, required Position position}){
    placeMark = placeMark;
    position = position;
  }

}