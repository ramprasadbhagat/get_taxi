import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_taxi/core/screens/address_form/address_form.dart';
import 'package:get_taxi/core/screens/login/login_page.dart';
import 'package:get_taxi/core/screens/main/main_page.dart';
import 'package:get_taxi/core/screens/profile/profile_page.dart';
import 'package:get_taxi/core/screens/registration/registration_page.dart';
import 'package:get_taxi/core/screens/search_address/search_address_page.dart';

import '../../model/route_journey.dart';
import '../core/screens/add_address/add_address.dart';
import '../core/screens/home/home_page.dart';

class CustomRouter{
  static const String initialPage= '/';
  static const String loginPage= '/login';
  static const String registrationPage = '/registration';
  static const String homePage = '/home';
  static const String searchAddressPage = '/search_address';
  static const String profilePage = '/profile';
  static const String addAddress = '/add_address';
  static const String addressForm = '/address_form';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    final dynamic arg;
    switch (settings.name) {
      case CustomRouter.initialPage:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case CustomRouter.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage(),);
      case CustomRouter.registrationPage:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case CustomRouter.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case CustomRouter.searchAddressPage:
        arg = settings.arguments as RouteJourney;
        return MaterialPageRoute(builder: (_) => SearchAddressPage(
          address: arg,
        ));
      case CustomRouter.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case CustomRouter.addAddress:
        arg = settings.arguments as Placemark;
        return MaterialPageRoute(builder: (_) => AddAddress(place: arg,));
      case CustomRouter.addressForm:
        arg = settings.arguments as Placemark;
        return MaterialPageRoute(builder: (_) => AddressForm(place: arg,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}')
              ),
            ));
    }
  }
}