import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_text_field.dart';

class RegistrationTextField extends StatelessWidget {
  final String text;
  final bool isObscure;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;

  const RegistrationTextField({
    Key? key,
    required this.text,
    this.isObscure = false,
    required this.validator,
    required this.controller,
    this.keyboardInputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CustomTextField(
        text: text,
        isObscure: isObscure,
        validator: (val)=>validator(val),
        controller: controller,
        keyboardInputType: keyboardInputType,
      );
}
