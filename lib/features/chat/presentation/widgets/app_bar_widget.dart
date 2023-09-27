import 'package:chat_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';

class ChatAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBarWidget({Key? key , required this.title}) : super(key: key);
  final String title ;
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.outerPadding),
      child: Container(
        height: size.height * 0.0788,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.white, width: 0.3))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.outerPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: AppColors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: AppStrings.boldFontFamily,
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                ],
              ),
              SizedBox(
                  height: size.height * 0.078,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0 , 0 ,10 , 0),
                        child: Icon(Icons.search , size: 25,),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0 , 0 ,10 , 0),
                        child: Icon(Icons.menu , size: 25,),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
