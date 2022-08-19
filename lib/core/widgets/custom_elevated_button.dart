import 'package:flutter/material.dart';
import 'package:get_taxi/utils/get_size.dart';

import '../../utils/app_color.dart';
import '../../utils/font_family_constant.dart';
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColor.yellowShade800,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 2,
          splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.symmetric(
          vertical: 4 * GetSize.getPixelHeight
        )
      ),
      onPressed: ()=> onPress(),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20,
            fontFamily: FontFamilyConstant.brandBold,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
