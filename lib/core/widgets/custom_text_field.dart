import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/show_password_cubit.dart';
import '../../utils/app_color.dart';
import '../../utils/get_size.dart';


class CustomTextField extends StatelessWidget {
  final String? text;
  final bool isObscure;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;

  const CustomTextField({
    Key? key,
    this.text,
    this.isObscure = false,
    required this.validator,
    required this.controller,
    this.keyboardInputType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 26 * GetSize.getPixelHeight,
      child: BlocProvider(
        create: (context) => ShowPasswordCubit(),
        child: BlocBuilder<ShowPasswordCubit, ShowPasswordState>(
          builder: (context, state) {
            return TextFormField(
              keyboardType: keyboardInputType,
              validator: (val) => validator(val),
              controller: controller,
              obscureText: text!=null&&text!.toLowerCase() == 'password' ? !state.show : isObscure,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.white24,
                  hintText: text,
                  suffixIcon: text!=null&&text!.toLowerCase() == 'password' ?
                  IconButton(
                    onPressed: () {
                      if (state.show) {
                        BlocProvider.of<ShowPasswordCubit>(context).disable();
                        return;
                      }
                      BlocProvider.of<ShowPasswordCubit>(context).enable();
                    },
                    icon: state.show ?
                      const Icon(Icons.visibility_sharp, color: AppColor.white54,) :
                      const Icon(Icons.visibility_off_sharp, color: AppColor.white24,),
                  ) : Container(width: 1,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        width: 2, color: AppColor.yellowShade800),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5 * GetSize.getPixelHeight,
                      horizontal: 12 * GetSize.getPixelWidth
                  )
              ),
            );
          },
        ),
      ),
    );
  }
}
