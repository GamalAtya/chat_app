


import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/features/home/presentation/bloc/conversations_bloc/conversations_bloc.dart';
import 'package:chat_app/features/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';
import '../widgets/home_screen_app_bar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const HomeScreenAppBar(title: "Menu"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: context.screenHeight * 0.75,
          child: ListView(
            reverse: true,
            children: [
             ListTile(
               tileColor: AppColors.primaryColor,
               title: Padding(
                 padding: EdgeInsets.fromLTRB(
                     AppConstants.outerPadding, 0, AppConstants.outerPadding, 0),
                 child: Text("Log Out",
                     style: TextStyle(
                         fontSize: 20,
                         color: AppColors.black,
                         fontFamily: AppStrings.boldFontFamily,
                         fontWeight: FontWeight.w700)),
               ),
               onTap: (){
                 context.read<HomeScreenBloc>().add(LogOutEvent());
               },
               leading: Icon(Icons.logout , size: 30, color: AppColors.black,),
             )
            ],
          ),
        ),
      ),
    );
  }
}
