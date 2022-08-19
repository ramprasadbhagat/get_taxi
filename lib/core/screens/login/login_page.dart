import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_taxi/core/widgets/custom_toast_message.dart';
import 'package:get_taxi/core/screens/login/widget/login_elevated_button.dart';
import 'package:get_taxi/core/screens/login/widget/login_int_text.dart';
import 'package:get_taxi/core/screens/login/widget/login_text_field.dart';
import 'package:get_taxi/utils/app_color.dart';
import 'package:get_taxi/utils/app_image.dart';
import 'package:get_taxi/utils/font_family_constant.dart';
import 'package:get_taxi/utils/get_size.dart';
import 'package:get_taxi/utils/hero_tag_constant.dart';

import '../../../bloc/show_loader_cubit.dart';
import '../../../main.dart';
import '../../../model/user_data.dart';
import '../../../repository_data/UserDataRepository.dart';
import '../../../router/custom_router.dart';
import '../../../utils/app_helper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserData? user;

  void loginUser(BuildContext context) async{
    if(_loginFormKey.currentState!.validate()){
      BlocProvider.of<ShowLoaderCubit>(context).enableLoader();
      bool isUserLogin = await loginWithAuth();
      if(isUserLogin){
        BlocProvider.of<ShowLoaderCubit>(context).disableLoader();
        RepositoryProvider.of<UserDataRepository>(context).setUserData(user: user!);
        CustomToastMessage.showMessage("you are logged-in now");
        Navigator.pushNamed(
          context,
          CustomRouter.homePage,
        );
      }else{
        BlocProvider.of<ShowLoaderCubit>(context).disableLoader();
        CustomToastMessage.showMessage("No user exit! Please create new account");
      }
    }
  }

  Future<bool> loginWithAuth()async{
    try {
      User? _user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text
      )).user;
      if (_user != null) {
        return await userRef.child(_user.uid).once().then((snap){
          print("---------------------------");
          print(snap.snapshot.value);
          var k = snap.snapshot.value as Map;
          if(snap.snapshot.value!=null) {
            user = UserData(
              name: k['name'].toString(),
              email: k['email'] .toString(),
              password: k['password'] .toString(),
              phone: k['phone'] .toString(),
            );
            return true;
          }
          _firebaseAuth.signOut();
          return false;
        });
      }
      return false;
    }catch(e) {
      print("exception error : $e");
      return false;
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
              key: _loginFormKey,
              child: BlocBuilder<ShowLoaderCubit, ShowLoaderState>(
                builder: (context, state) {
                return Stack(
                alignment: Alignment.center,
                children: [
                  AbsorbPointer(
                    absorbing: state.show,
                    child: Opacity(
                      opacity: state.show ?0.6 : 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 40 * GetSize.getPixelHeight,),
                          Hero(
                            tag: HeroTagConstant.splashToLogin,
                            child: Image.asset(
                              AppImage.mainLogo,
                              height: 100 * GetSize.getPixelHeight,
                              alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: 20 * GetSize.getPixelHeight,),
                          const Text(
                            "Login as  a Rider",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: FontFamilyConstant.brandBold,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15 * GetSize.getPixelHeight,),
                          LoginTextField(
                            text: "Email",
                            validator: (val)=>AppHelper.emailValidator(val),
                            controller: emailTextEditingController,
                            keyboardInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 7 * GetSize.getPixelHeight,),
                          LoginTextField(
                            text: "Password",
                            isObscure: true,
                            validator: (val)=>AppHelper.passwordValidator(val),
                            controller: passwordTextEditingController,
                            keyboardInputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 48 * GetSize.getPixelHeight,),
                          LoginElevatedButton(
                            text: "Login",
                            onPress: ()=> loginUser(context),
                          ),
                          SizedBox(height: 5 * GetSize.getPixelHeight,),
                          const Center(
                            child: LoginInkText(
                              text: "Do not have an account? Register here.",
                              routeName: CustomRouter.registrationPage,
                            ),
                          )
                        ],
                      ),
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


}
