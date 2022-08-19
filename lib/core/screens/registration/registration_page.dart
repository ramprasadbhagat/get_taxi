import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_taxi/core/widgets/custom_toast_message.dart';
import 'package:get_taxi/core/screens/registration/widget/registration_elevated_button.dart';
import 'package:get_taxi/core/screens/registration/widget/registration_int_text.dart';
import 'package:get_taxi/core/screens/registration/widget/registration_text_field.dart';
import 'package:get_taxi/main.dart';
import 'package:get_taxi/utils/app_image.dart';
import 'package:get_taxi/utils/font_family_constant.dart';
import 'package:get_taxi/utils/get_size.dart';
import 'package:get_taxi/utils/hero_tag_constant.dart';

import '../../../bloc/show_loader_cubit.dart';
import '../../../model/user_data.dart';
import '../../../router/custom_router.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_helper.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();

  final _registrationFormKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserData? user;

  void registerUser(BuildContext context)async{
      if(_registrationFormKey.currentState!.validate()){
        BlocProvider.of<ShowLoaderCubit>(context).enableLoader();
        bool? isRegisterSuccess = await registerUserWithAuth(context);
        if(isRegisterSuccess == null){
          BlocProvider.of<ShowLoaderCubit>(context).disableLoader();
          CustomToastMessage.showMessage("The email address is already in use by another account");
        }
        else if(isRegisterSuccess){
          BlocProvider.of<ShowLoaderCubit>(context).disableLoader();
          // RepositoryProvider.of<UserDataRepository>(context).setUserData(user: _user!);
          CustomToastMessage.showMessage("User account has been created");
          Navigator.pushReplacementNamed(
            context,
            CustomRouter.homePage,
            // arguments: _user
          );
        }else{
          BlocProvider.of<ShowLoaderCubit>(context).disableLoader();
          CustomToastMessage.showMessage("User account has not been created");
        }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 15 * GetSize.getPixelHeight,
                horizontal: 15 * GetSize.getPixelWidth
            ),
            child: Form(
              key: _registrationFormKey,
              child: BlocBuilder<ShowLoaderCubit, ShowLoaderState>(
                builder: (context, state) {
                return Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: state.show ?0.6 : 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15 * GetSize.getPixelHeight,),
                        Hero(
                          tag: HeroTagConstant.splashToLogin,
                          child: Image.asset(
                            AppImage.mainLogo,
                            height: 88 * GetSize.getPixelHeight,
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(height: 15 * GetSize.getPixelHeight,),
                        const Text(
                          "Register as a Rider",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: FontFamilyConstant.brandBold,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15 * GetSize.getPixelHeight,),
                        RegistrationTextField(
                          text: "Name",
                          validator: (val)=>AppHelper.nameValidator(val),
                          controller: nameTextEditingController,
                          keyboardInputType: TextInputType.name,
                        ),
                        SizedBox(height: 7 * GetSize.getPixelHeight,),
                        RegistrationTextField(
                          text: "Email",
                          validator: (val)=>AppHelper.emailValidator(val),
                          controller: emailTextEditingController,
                          keyboardInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 7 * GetSize.getPixelHeight,),
                        RegistrationTextField(
                          text: "Phone",
                          validator: (val)=>AppHelper.phoneValidator(val),
                          controller: phoneTextEditingController,
                          keyboardInputType: TextInputType.phone,
                        ),
                        SizedBox(height: 7 * GetSize.getPixelHeight,),
                        RegistrationTextField(
                          text: "Password",
                          isObscure: true,
                          validator: (val)=>AppHelper.passwordValidator(val),
                          controller: passwordTextEditingController,
                          keyboardInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 25 * GetSize.getPixelHeight,),
                        RegistrationElevatedButton(
                          text: 'Register',
                          onPress: ()=>registerUser(context),
                        ),
                        SizedBox(height: 5 * GetSize.getPixelHeight,),
                        const Center(
                          child: RegistrationInkText(
                            text: "Already have an account? Login here.",
                            routeName: CustomRouter.loginPage,
                          )
                        )
                      ],
                    ),
                  ),
                  if(state.show)
                     Center(
                      child: CircularProgressIndicator(
                        color: AppColor.yellowShade800,
                      ),
                    )
                ],
              );
              },
            ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> registerUserWithAuth( BuildContext context)async {
    try {
      User? _user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text
      )).user;
      if (_user != null) {
        Map userDataMap = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
          "password": passwordTextEditingController.text.trim()
        };

        userRef.child(_user.uid).set(userDataMap);
        user = UserData(
          name: nameTextEditingController.text.trim(),
          email: emailTextEditingController.text.trim(),
          phone: phoneTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        );
        return true;
      }
      return false;
    }catch(e) {
      print("exception error : $e");
      return null;
    }
  }
}
