import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_taxi/core/screens/home/bloc/bottom_map_padding_cubit.dart';
import 'package:get_taxi/core/screens/home/bloc/source_address_cubit.dart';
import 'package:get_taxi/core/screens/home/data/sourceAddressRepository.dart';
import 'package:get_taxi/core/screens/home/services/Services.dart';
import 'package:get_taxi/core/screens/home/widget/custom_address_template.dart';
import 'package:get_taxi/core/screens/home/widget/custom_drawer.dart';
import 'package:get_taxi/utils/app_color.dart';
import 'package:get_taxi/utils/get_size.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/route_journey.dart';
import '../../../model/user_data.dart';
import '../../../repository_data/UserDataRepository.dart';
import '../../../router/custom_router.dart';
import '../../../utils/font_family_constant.dart';
import '../../../utils/hero_tag_constant.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? _newGoogleMapController;
  Position? currentPosition;
  String sourceAddress="";
  RouteJourney? address;
  UserData? user;
  Placemark? place;

  static CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placeMarks);
    place = placeMarks[0];
    RepositoryProvider.of<SourceAddressRepository>(context).setLocation(placeMark: place!, position: position);
    sourceAddress = '${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.postalCode}, ${place!.country}';
    address = RouteJourney(source: sourceAddress,);
    BlocProvider.of<SourceAddressCubit>(context).editAddress(sourceAddress: sourceAddress);
  }


  Future<void> locatePosition()async{
    currentPosition = await Services.determinePosition();
    LatLng _latLng = LatLng(currentPosition!.latitude,currentPosition!.longitude);
    CameraPosition cameraPosition = CameraPosition(target: _latLng, zoom: 14);
    _newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    getAddressFromLatLong(currentPosition!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = RepositoryProvider.of<UserDataRepository>(context).user;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newGoogleMapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book your Taxi"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Stack(
          children: [
            BlocProvider(
            create: (context) => BottomMapPaddingCubit(),
              child: BlocBuilder<BottomMapPaddingCubit, BottomMapPaddingState>(
                builder: (context, state) {
                  return GoogleMap(
                    padding: EdgeInsets.only(
                      bottom: state.bottomPadding * GetSize.getPixelHeight
                    ),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: kGooglePlex,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller)async {
                      _controllerGoogleMap.complete(controller);
                      _newGoogleMapController=controller;
                      BlocProvider.of<BottomMapPaddingCubit>(context).changeBottomPadding(180);
                      await locatePosition();
                    },
                  );
                },
              ),
            ),
            BlocBuilder<SourceAddressCubit, AddressState>(
              builder: (context, state1) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                    child: Container(
                    height: 182 * GetSize.getPixelHeight,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: Colors.grey.shade800,
                          offset:const Offset(0.7, 0.7),
                          spreadRadius: 0.5
                        )
                      ],
                      color: Colors.grey.shade800
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12 * GetSize.getPixelHeight,
                        horizontal: 18 * GetSize.getPixelWidth
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "hi",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 5 * GetSize.getPixelWidth,),
                              Text(
                                "${user!.email?.split('@')[0].toUpperCase()},",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: FontFamilyConstant.brandBold
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4 * GetSize.getPixelHeight,),
                          const Text(
                            "Pick up location",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FontFamilyConstant.brandRegular
                            ),
                          ),
                          SizedBox(height: 3 * GetSize.getPixelHeight,),
                          Hero(
                            tag: HeroTagConstant.homeToSetDropOffSource,
                            child: InkWell(
                              onTap: ()async{
                                RouteJourney x = await Navigator.pushNamed(
                                    context,
                                    CustomRouter.searchAddressPage,
                                    arguments: address
                                ) as RouteJourney;
                                address = x;
                                BlocProvider.of<SourceAddressCubit>(context).editAddress(
                                  sourceAddress: address?.source ?? '',
                                  destinationAddress: address?.destination
                                );
                              } ,
                              child: Container(
                                height: 20 * GetSize.getPixelHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey.shade600,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12 * GetSize.getPixelWidth
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: state1 is AddressEditState ? Text(
                                          state1.sourceAddress,
                                          overflow: TextOverflow.ellipsis
                                      ) :  const Text(
                                          "Your current location",
                                      ),
                                    ),
                                    const Icon(
                                      Icons.edit,
                                      color: AppColor.white54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5 * GetSize.getPixelHeight,),
                          const Text(
                            "Where to?",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FontFamilyConstant.brandRegular
                            ),
                          ),
                          SizedBox(height: 5 * GetSize.getPixelHeight,),
                          Hero(
                            tag: HeroTagConstant.homeToSetDropOffDestination,
                            child: InkWell(
                              onTap: ()async{
                                RouteJourney x = await Navigator.pushNamed(
                                    context,
                                    CustomRouter.searchAddressPage,
                                    arguments: address
                                ) as RouteJourney;
                                address = x;
                                BlocProvider.of<SourceAddressCubit>(context).editAddress(
                                    sourceAddress: address?.source ?? '',
                                    destinationAddress: address?.destination
                                );
                              } ,
                              child: Container(
                                height: 20 * GetSize.getPixelHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey.shade600,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12 * GetSize.getPixelWidth
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: AppColor.white54,
                                    ),
                                    SizedBox(
                                      width: 8 * GetSize.getPixelWidth,
                                    ),
                                    Expanded(
                                      child:state1 is AddressEditState ? Text(
                                          state1.destinationAddress ?? "Search drop off",
                                          overflow: TextOverflow.ellipsis
                                      ) :  const Text(
                                        "Search drop off",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8 * GetSize.getPixelHeight,),
                          CustomAddressTemplate(
                            icon: Icons.home,
                            title: "Add home",
                            subTitle: "Your living home address",
                            trailingIcon: Icons.add_circle_outline,
                            onTap: (){
                              if(place != null){
                                Navigator.pushNamed(
                                  context,
                                  CustomRouter.addAddress,
                                  arguments: place,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 5 * GetSize.getPixelHeight,),
                          const Divider(height: 1,color: Colors.grey,),
                          SizedBox(height: 4 * GetSize.getPixelHeight,),
                          CustomAddressTemplate(
                            icon: Icons.work,
                            title: "Add office",
                            trailingIcon: Icons.add_circle_outline,
                            subTitle: "Your office address",
                            onTap: (){
                              if(place != null){
                                Navigator.pushNamed(
                                  context,
                                  CustomRouter.addAddress,
                                  arguments: place,
                                );
                              }
                            },

                          )
                        ],
                      ),
                    )
                  )
                );
              },
            )
          ],
        )
    );
  }
}
