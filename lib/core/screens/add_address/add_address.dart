import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_taxi/core/screens/add_address/widget/address_card.dart';
import 'package:get_taxi/core/screens/address_form/address_form.dart';
import 'package:get_taxi/core/screens/add_address/widget/address_elevated_button.dart';
import 'package:get_taxi/core/widgets/custom_elevated_button.dart';
import 'package:get_taxi/model/address_info.dart';
import 'package:get_taxi/model/user_data.dart';
import 'package:get_taxi/repository_data/UserDataRepository.dart';
import 'package:get_taxi/router/custom_router.dart';
import 'package:get_taxi/utils/get_size.dart';


class AddAddress extends StatelessWidget {
  final Placemark place;

  const AddAddress({Key? key, required this.place}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    UserDataRepository userDataRepository = RepositoryProvider.of<UserDataRepository>(context);
    UserData user = userDataRepository.user!;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Address",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            if(user.homeAddress.isNotEmpty)
            ListView.builder(
              itemCount: user.homeAddress.length,
              itemBuilder: (context, i){
                return Column(
                  children: [
                    Container(height: 300, color: Colors.yellow[100 * i],),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 20 * GetSize.getPixelHeight,
              child: Container(
                width: GetSize.getScreenWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: 24 * GetSize.getPixelWidth
                ),
                child: AddressElevatedButton(
                  text: "+ add address",
                  onPress:()=> Navigator.pushNamed(
                    context,
                    CustomRouter.addressForm,
                    arguments: place
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

