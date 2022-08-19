import 'address_info.dart';
import 'route_journey.dart';

class UserData{
  String? name;
  String? phone;
  String? email;
  String? password;
  List<AddressInfo> homeAddress;
  String? defaultHomeAddress;
  List<AddressInfo> officeAddress;
  String? defaultOfficeAddress;
  RouteJourney? address;
  UserData({
    this.email,
    this.phone,
    this.name,
    this.homeAddress= const [],
    this.officeAddress=const [],
    this.password,
    this.address,
    this.defaultHomeAddress,
    this.defaultOfficeAddress
  });
}