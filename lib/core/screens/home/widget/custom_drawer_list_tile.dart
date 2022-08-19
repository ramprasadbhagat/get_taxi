import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_list_tile_template.dart';


class CustomDrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  const CustomDrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTileTemplate(
      title: title,
      leadingIcon: icon,
      onTap: onTap,
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: 18 * GetSize.getPixelWidth
    //   ),
    //   child: Row(
    //     children: [
    //       Icon(icon),
    //       SizedBox(width: 22 * GetSize.getPixelWidth,),
    //       Text(
    //           title,
    //         style: const TextStyle(
    //             fontSize: 18,
    //           fontFamily: FontFamilyConstant.brandRegular
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}