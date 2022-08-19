import 'package:flutter/material.dart';
import 'package:get_taxi/utils/app_color.dart';
import 'package:get_taxi/utils/get_size.dart';
import 'package:google_place/google_place.dart';
import '../../../model/route_journey.dart';
import '../../config_map/config_map.dart';

class SearchAddressPage extends StatelessWidget {

  final RouteJourney address;
  const SearchAddressPage({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextEditingController sourceTextEditingController =  TextEditingController(text: address.source);
    final TextEditingController destinationTextEditingController =  TextEditingController(text: address.destination);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()async{
            RouteJourney x=RouteJourney(
              source: sourceTextEditingController.text,
              destination: destinationTextEditingController.text
            );
            Navigator.pop(
              context,
              x
            );
            return Future(() => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Set drop off"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Material(
        elevation: 10,
        child: Container(
          color: AppColor.greyShade800,
          padding: EdgeInsets.symmetric(
            horizontal: 20 * GetSize.getPixelWidth
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20 * GetSize.getPixelHeight,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pin_drop,
                    size: 34,
                    color: Colors.red,
                  ),
                  // Image.asset(
                  //     AppImage.pickIcon,
                  //   height: 32,
                  // ),
                  SizedBox(
                    width: 12 * GetSize.getPixelWidth,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (val)=>findPlace(val, context),
                      controller: sourceTextEditingController,
                      decoration: InputDecoration(
                          fillColor: AppColor.greyShade900,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12 * GetSize.getPixelWidth,
                              vertical: 0
                          )
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15 * GetSize.getPixelHeight,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 34,
                    color: Colors.red,
                  ),
                  // Image.asset(
                  //   AppImage.destIcon,
                  //   height: 32,
                  // ),
                  SizedBox(
                    width: 12 * GetSize.getPixelWidth,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (val)=>findPlace(val, context),
                      controller: destinationTextEditingController,
                      decoration: InputDecoration(
                        fillColor: AppColor.greyShade900,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12 * GetSize.getPixelWidth,
                          vertical: 0
                        )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20 * GetSize.getPixelHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void findPlace(String val, BuildContext context) async{

    const kGoogleApiKey = androidConfigMapApiKey;

    var googlePlace = GooglePlace(kGoogleApiKey);
    var result = await googlePlace.autocomplete.get(val);
    print("!!!!!!! : ${result?.status}");

  }
  //   String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$val&location=37.76999%2C-122.44696&radius=500&strictbounds=true&types=establishment&key=YOUR_API_KEY';
  //   if(val.isNotEmpty){
  //     String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$val&types=geocode&key=$androidConfigMapApiKey';
  //     try {
  //       var response = await Dio().get(url);
  //       if(response.statusCode == 200){
  //         print("status code");
  //       }
  //       print(response);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }
}
