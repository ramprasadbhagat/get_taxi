

import '../../model/address_info.dart';
import '../../model/route_journey.dart';
import '../../model/user_data.dart';

class UserDataRepository{
  UserData? user;
  void setUserData({required UserData user}){
    this.user =user;
  }
  void setHomeAddress({required AddressInfo x}){
    user?.homeAddress?.add(x);
  }
  void setOfficeAddress({required AddressInfo x}){
    user?.officeAddress?.add(x);
  }
  void setRouteJourney({required RouteJourney x}){
    user?.address=x;
  }

}