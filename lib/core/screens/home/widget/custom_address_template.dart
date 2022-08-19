import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_list_tile_template.dart';

class CustomAddressTemplate extends StatelessWidget {

  final String title;
  final String? subTitle;
  final IconData icon;
  final Function()? onTap;
  final IconData? trailingIcon;

  const CustomAddressTemplate({
    Key? key,
    required this.title,
    this.subTitle,
    required this.icon,
    this.onTap,
    this.trailingIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTileTemplate(
      title: title,
      leadingIcon: icon,
      subTitle: subTitle,
      onTap: onTap,
      trailingIcon: trailingIcon,
    );
  }
}
