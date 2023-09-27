


import 'package:chat_app/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const HomeScreenAppBar({Key? key , required this.title}) : super(key: key);
  final String title ;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.white,
        centerTitle: false,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(AppConstants.outerPadding, 0,
                AppConstants.outerPadding, 0),
            child: SizedBox(
              width: context.screenWidth * 0.07,
              height: context.screenHeight * 0.03,
              child: SvgPicture.asset(AppStrings.newChatIcon),
            ),
          )
        ],
        title: Padding(
          padding: EdgeInsets.fromLTRB(
              AppConstants.outerPadding, 0, AppConstants.outerPadding, 0),
          child: Text(title,
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.black,
                  fontFamily: AppStrings.boldFontFamily,
                  fontWeight: FontWeight.w700)),
        ));
  }


  @override
  Size get preferredSize =>const Size.fromHeight(60);
}
