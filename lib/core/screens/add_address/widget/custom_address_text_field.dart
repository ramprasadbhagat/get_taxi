import 'package:flutter/material.dart';
import 'package:get_taxi/core/widgets/custom_text_field.dart';
import 'package:get_taxi/utils/get_size.dart';

class CustomAddressTexTField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomAddressTexTField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5 * GetSize.getPixelHeight,
        ),
        CustomTextField(
          validator: validator,
          controller: controller
        ),
      ],
    );
  }
}
