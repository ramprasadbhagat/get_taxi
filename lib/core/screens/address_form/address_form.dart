import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_taxi/core/screens/add_address/bloc/set_location_as_pick_up_cubit.dart';
import 'package:get_taxi/core/screens/add_address/widget/custom_address_text_field.dart';
import 'package:get_taxi/utils/get_size.dart';

import '../../../utils/app_color.dart';
import 'package:country_picker/country_picker.dart';

import '../add_address/bloc/update_country_cubit.dart';

class AddressForm extends StatefulWidget {
  final Placemark place;

  const AddressForm({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {

  late final TextEditingController addressController1;
  late final TextEditingController addressController2;
  late final TextEditingController cityController;
  late final TextEditingController countryController;
  late final TextEditingController postalCodeController;
  bool setLocationAsPickUp = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController1 = TextEditingController();
    addressController2 = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    postalCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController1.dispose();
    addressController2.dispose();
    cityController.dispose();
    countryController.dispose();
    postalCodeController.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  UpdateCountryCubit(country: widget.place.country!),
            ),
            BlocProvider(
              create: (context) => SetLocationAsPickUpCubit(),
            ),
          ],
          child: Container(
            margin: EdgeInsets.only(
                top: 14 * GetSize.getPixelHeight,
                bottom: 18 * GetSize.getPixelHeight,
                right: 18 * GetSize.getPixelWidth,
                left: 18 * GetSize.getPixelWidth
            ),
            child: Material(
              elevation: 20,
              child: Container(
                height: 280 * GetSize.getPixelHeight,
                padding: EdgeInsets.only(
                    top: 10 * GetSize.getPixelHeight,
                    bottom: 10 * GetSize.getPixelHeight,
                    right: 13 * GetSize.getPixelWidth,
                    left: 13 * GetSize.getPixelWidth
                ),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  color: Colors.black38,
                  border: Border.all(
                    color: Colors.white24
                  ),
                ),
                child: BlocBuilder<SetLocationAsPickUpCubit, SetLocationAsPickUpState>(
                  builder: (context, state1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 240 * GetSize.getPixelWidth,
                              child: const Text(
                                "Set pick up Location as an Address",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            Switch(
                              activeColor: Colors.yellowAccent,
                              value: state1.isSet,
                              onChanged: (val) {
                                if (val) {
                                  addressController1.text = widget.place.street!;
                                  addressController2.text = widget.place.subLocality!;
                                  cityController.text=widget.place.locality!;
                                  countryController.text=widget.place.country!;
                                  postalCodeController.text=widget.place.postalCode!;
                                  BlocProvider.of<SetLocationAsPickUpCubit>(context)
                                      .setLocationAsPickUpPoint(val);
                                } else {
                                  addressController1.clear();
                                  addressController2.clear();
                                  cityController.clear();
                                  countryController.clear();
                                  postalCodeController.clear();
                                  BlocProvider.of<SetLocationAsPickUpCubit>(context)
                                      .setLocationAsPickUpPoint(val);
                                }
                                print("val : $val");
                                setState(() {
                                  setLocationAsPickUp = val;
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10 * GetSize.getPixelHeight,
                        ),
                        CustomAddressTexTField(
                          labelText: "Address line 1",
                          controller: addressController1,
                          validator: (val){},
                        ),
                        SizedBox(
                          height: 10 * GetSize.getPixelHeight,
                        ),
                        CustomAddressTexTField(
                            labelText: "Address line 2(Optional)",
                            controller: addressController2,
                          validator: (val){},

                        ),
                        SizedBox(
                          height: 10 * GetSize.getPixelHeight,
                        ),
                        CustomAddressTexTField(
                            labelText: "City",
                            controller: cityController,
                          validator: (val){},

                        ),
                        SizedBox(
                          height: 10 * GetSize.getPixelHeight,
                        ),
                        const Text(
                          "Country",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 5 * GetSize.getPixelHeight,
                        ),
                        BlocBuilder<UpdateCountryCubit, UpdateCountryState>(
                          builder: (context, state) {
                            countryController.text = state.country;
                            return TextFormField(
                              readOnly: true,
                              controller: countryController,
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,
                                    backgroundColor: AppColor.greyShade900,
                                    textStyle: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    bottomSheetHeight: 180 * GetSize.getPixelHeight,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    inputDecoration: const InputDecoration(
                                      hintText: 'Start typing to search',
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // showPhoneCode: true, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    // setState(() {
                                    countryController.text = country.name;
                                    BlocProvider.of<UpdateCountryCubit>(context)
                                        .updateCountryName(country.name);
                                    // });
                                  },
                                );
                              },
                              // enabled: false,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.white24,
                                  suffixIcon: const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.yellowAccent,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.yellowShade800),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5 * GetSize.getPixelHeight,
                                      horizontal: 12 * GetSize.getPixelWidth
                                  )
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10 * GetSize.getPixelHeight,
                        ),
                        const Text(
                          "ZIP / postcode",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 5 * GetSize.getPixelHeight,
                        ),
                        SizedBox(
                          width: 100 * GetSize.getPixelWidth,
                          child: TextFormField(
                            controller: postalCodeController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.white24,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColor.yellowShade800),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5 * GetSize.getPixelHeight,
                                    horizontal: 12 * GetSize.getPixelWidth
                                )
                            ),
                          ),
                        ),
                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                              ),
                              onPressed: ()=> Navigator.pop(context),
                              child: const Text(
                                  "Cancel",
                              )
                            ),
                            SizedBox(
                              width: 12 * GetSize.getPixelWidth,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.black,
                                  primary: Colors.amberAccent,
                              ),
                                onPressed: (){},
                                child: const Text(
                                    "Confirm",
                                  // style: TextStyle(
                                  //   color: AppColor.purple
                                  // ),
                                )
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
    );
  }
}
