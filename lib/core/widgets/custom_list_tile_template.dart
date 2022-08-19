import 'package:flutter/material.dart';
import '../../utils/font_family_constant.dart';
import '../../utils/get_size.dart';


class CustomListTileTemplate extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData leadingIcon;
  final Function()? onTap;
  final IconData? trailingIcon;
  final double gapBetweenLeadingTitle;
  const CustomListTileTemplate({
    Key? key,
    required this.title,
    this.subTitle,
    required this.leadingIcon,
    this.onTap,
    this.trailingIcon,
    this.gapBetweenLeadingTitle = 5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22 * GetSize.getPixelHeight,
      // color: Colors.red,
      alignment: Alignment.topCenter,
      child: ListTile(
        onTap: onTap,
        dense: true,
        horizontalTitleGap: gapBetweenLeadingTitle,
        contentPadding: EdgeInsets.only(
          right: 12 * GetSize.getPixelWidth
        ),
        minVerticalPadding: 0,
        visualDensity: VisualDensity.compact,
        leading: Icon(leadingIcon, size: 24,),
        trailing: Icon(trailingIcon, size: 28,),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontFamily: FontFamilyConstant.brandBold
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subTitle != null ? Text(
          subTitle!,
          style: const TextStyle(
              fontSize: 16,
              // fontFamily: FontFamilyConstant.brandRegular
          ),
          overflow: TextOverflow.ellipsis,
        ) : null,
      ),
    );
    return Row(
      children: [
        Icon(leadingIcon),
        SizedBox(width: 12 * GetSize.getPixelWidth,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: FontFamilyConstant.brandBold
              ),
            ),
            Text(
              subTitle!,
              style: const TextStyle(
                  fontSize: 16,
                  // fontFamily: FontFamilyConstant.brandRegular
              ),
            ),

          ],
        )
      ],
    );
  }
}
