import 'package:flutter/material.dart';
import 'package:get_taxi/utils/app_image.dart';
import 'package:get_taxi/utils/get_size.dart';

import '../../../router/custom_router.dart';
import '../../../utils/hero_tag_constant.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginScreen();
  }

  void getLoginScreen()async{
    await Future.delayed(const Duration(seconds: 3)).then((value){
      Navigator.pushReplacementNamed(context, CustomRouter.loginPage,);
    });
  }


  @override
  Widget build(BuildContext context) {
    GetSize.init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: HeroTagConstant.splashToLogin,
              child: Image.asset(
                AppImage.mainLogo,
                height: 180 * GetSize.getPixelHeight,
                width: 220 * GetSize.getPixelWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
