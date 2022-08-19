import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_elevated_button.dart';

class CustomEditProfileButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const CustomEditProfileButton({Key? key, required this.text, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(text: text, onPress: onPress);
  }
}
