import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_list_tile_template.dart';

class CustomProfileListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final double gapBetweenLeadingTitle;
  const CustomProfileListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.gapBetweenLeadingTitle = 5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTileTemplate(
      title: title,
      leadingIcon: leadingIcon,
      gapBetweenLeadingTitle : gapBetweenLeadingTitle,
    );
  }
}
