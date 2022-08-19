import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../router/custom_router.dart';

import '../../../../model/user_data.dart';
import '../../../../repository_data/UserDataRepository.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../../../../utils/get_size.dart';
import 'custom_drawer_list_tile.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    UserData? user = RepositoryProvider.of<UserDataRepository>(context).user;
    return Drawer(
      width: GetSize.getScreenWidth * 0.6,
      backgroundColor: AppColor.greyShade900,
      child: Column(
        children: [
          SizedBox(
            height: 100 * GetSize.getPixelHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 12 * GetSize.getPixelWidth
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10 * GetSize.getPixelHeight,),
                  InkWell(
                    onTap: (){},
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImage.userIcon,
                          height: 35 * GetSize.getPixelHeight,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0 ,
                          child: Container(
                            padding: EdgeInsets.all(
                              4 * GetSize.getPixelWidth
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: AppColor.yellowShade800
                            ),
                            child: const Opacity(
                              opacity: 0.7,
                                child: Icon(Icons.edit_rounded,size: 18,)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 18 * GetSize.getPixelWidth,),
                  Flexible(
                    child: Text("${user?.email?.split('@')[0].toUpperCase()}")
                  ),
                  SizedBox(height: 2 * GetSize.getPixelHeight,),
                ],
              ),
          ),
          ),
          const Divider(height: 1,color: Colors.grey,),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * GetSize.getPixelWidth
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 8 * GetSize.getPixelHeight,
                ),
                CustomDrawerListTile(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: ()=>Navigator.pushNamed(context, CustomRouter.profilePage),
                ),
                const CustomDrawerListTile(
                  icon: Icons.history,
                  title: "History",
                ),
                const CustomDrawerListTile(
                  icon: Icons.help,
                  title: "About",
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(height: 1,color: Colors.grey,),
          SizedBox(height: 10 * GetSize.getPixelHeight,),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16 * GetSize.getPixelWidth
            ),
            child: const CustomDrawerListTile(
              icon: Icons.logout,
              title: "Logout",
            ),
          ),
          SizedBox(height: 12 * GetSize.getPixelHeight,),
        ],
      ),
    );
  }
}

