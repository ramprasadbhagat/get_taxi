import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_ink_text.dart';

class LoginInkText extends StatelessWidget {
  final String text;
  final String routeName;
  const LoginInkText({
    Key? key,
    required this.text,
    required this.routeName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CustomInkText(text: text, routeName: routeName);
}
