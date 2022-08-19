import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
class CustomInkText extends StatelessWidget {
  final String text;
  final String routeName;
  const CustomInkText({
    Key? key,
    required this.text,
    required this.routeName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, routeName);
      },
      child: Text(
        text,
        style: const TextStyle(
            color: AppColor.blue
        ),
      ),
    );
  }
}
