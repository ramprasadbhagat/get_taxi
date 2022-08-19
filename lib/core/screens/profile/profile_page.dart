
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_taxi/core/screens/profile/widget/custom_edit_profile_button.dart';
import 'package:get_taxi/core/screens/profile/widget/custom_profile_list_tile.dart';
import 'package:get_taxi/utils/app_color.dart';
import 'package:get_taxi/utils/get_size.dart';

import '../../../model/user_data.dart';
import '../../../repository_data/UserDataRepository.dart';
import '../../../utils/app_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final UserData? user = RepositoryProvider.of<UserDataRepository>(context).user!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: GetSize.getScreenHeight * 0.33,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -10 * GetSize.getPixelHeight,
                  left: -30 * GetSize.getPixelWidth,
                  right: -30 * GetSize.getPixelWidth,
                  child: Container(
                    height: GetSize.getScreenHeight * 0.3,
                    decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(280),
                          bottomRight: Radius.circular(280)
                        ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple, Colors.purple.shade100,])
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5 * GetSize.getPixelHeight,
                  child: Image.asset(
                    AppImage.userIcon,
                    height: 42 * GetSize.getPixelHeight,
                  ),
                ),
                Positioned(
                  left: 2 * GetSize.getPixelWidth,
                  top: 18 * GetSize.getPixelHeight,
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25 * GetSize.getPixelHeight,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 10 * GetSize.getPixelWidth,
              left: 30 * GetSize.getPixelWidth,
              top: 4 * GetSize.getPixelHeight,
            ),
            child: CustomProfileListTile(
              title: user!.name.toString(),
              leadingIcon: Icons.person,
              gapBetweenLeadingTitle: 30,
            ),
          ),
          const Divider(height: 1,color: AppColor.white24,),
          Padding(
            padding: EdgeInsets.only(
                right: 10 * GetSize.getPixelWidth,
                left: 30 * GetSize.getPixelWidth,
                top: 4 * GetSize.getPixelHeight
            ),
            child: CustomProfileListTile(
              title: user.phone.toString(),
              leadingIcon: Icons.phone,
              gapBetweenLeadingTitle: 30,
            ),
          ),
          const Divider(height: 1,color: AppColor.white24,),
          Padding(
            padding: EdgeInsets.only(
                right: 10 * GetSize.getPixelWidth,
                left: 30 * GetSize.getPixelWidth,
                top: 4 * GetSize.getPixelHeight
            ),
            child: CustomProfileListTile(
              title: user.email.toString(),
              leadingIcon: Icons.email,
              gapBetweenLeadingTitle: 30,
            ),
          ),
          const Divider(height: 1,color: AppColor.white24,),
          Padding(
            padding: EdgeInsets.only(
                right: 10 * GetSize.getPixelWidth,
                left: 30 * GetSize.getPixelWidth,
                top: 4 * GetSize.getPixelHeight
            ),
            child: CustomProfileListTile(
              title: user.password.toString(),
              leadingIcon: Icons.visibility_outlined,
              gapBetweenLeadingTitle: 30,
            ),
          ),
          const Divider(height: 1,color: AppColor.white24,),
          Padding(
            padding: EdgeInsets.only(
                right: 10 * GetSize.getPixelWidth,
                left: 30 * GetSize.getPixelWidth,
                top: 4 * GetSize.getPixelHeight
            ),
            child: CustomProfileListTile(
              title: user.defaultHomeAddress !=null ? user.defaultHomeAddress.toString() : "Add home address",
              leadingIcon: Icons.home,
              gapBetweenLeadingTitle: 30,
            ),
          ),
          const Divider(height: 1,color: AppColor.white24,),
          Padding(
            padding: EdgeInsets.only(
                right: 10 * GetSize.getPixelWidth,
                left: 30 * GetSize.getPixelWidth,
                top: 4 * GetSize.getPixelHeight
            ),
            child: CustomProfileListTile(
              title: user.defaultOfficeAddress !=null ? user.defaultOfficeAddress.toString() : "Add Office address",
              leadingIcon: Icons.work,
              gapBetweenLeadingTitle: 30,
            ),
          ),

          const Divider(height: 1,color: AppColor.white24,),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30 * GetSize.getPixelWidth,
            ),
            child: CustomEditProfileButton(
              text: "Edit profile",
              onPress: (){}
            ),
          ),
          SizedBox(
            height: 18 * GetSize.getPixelHeight,
          )
        ],
      ),
    );
  }
}
