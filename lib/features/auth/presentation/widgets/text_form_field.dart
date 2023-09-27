


import 'package:chat_app/core/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({Key? key, this.hintText , required this.controller , this.hideText = false , this.validator}) : super(key: key);
  final String? hintText ;
  final TextEditingController controller;
  final bool hideText;
  final String? Function(String?)? validator ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(15),
      child: Container(
        height: context.screenHeight * 0.1,
        width: context.screenWidth * 0.9,
        decoration: BoxDecoration(
            color: AppColors.highlightColor,
            borderRadius: BorderRadius.circular(AppConstants.radius)
        ),
        child: Center(
          child: TextFormField(
            obscureText: hideText,
            controller: controller,
            validator: validator,
            style:TextStyle(
                fontSize: 18,
                fontFamily: AppStrings.regularFontFamily,
                fontWeight: FontWeight.w600,

            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(AppConstants.outerPadding, 0, AppConstants.outerPadding, 0),
                enabledBorder: InputBorder.none,
                hintText: hintText
            ),
          ),
        ),
      ),
    );
  }
}
