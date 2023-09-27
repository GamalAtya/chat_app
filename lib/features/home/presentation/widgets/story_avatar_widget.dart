import 'package:chat_app/core/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/app_strings.dart';
import 'chat_avatar_widget.dart';

class StoryAvatarWidget extends StatelessWidget {
  const StoryAvatarWidget({Key? key, this.forMe = false, this.userName = ''})
      : super(key: key);
  final bool forMe;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
      child: SizedBox(
        height: context.screenHeight * 0.093,
        width: context.screenWidth * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: context.screenHeight * 0.068,
              width: context.screenWidth * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: forMe
                          ? [
                              AppColors.grey,
                              AppColors.grey,
                            ]
                          : [
                              AppColors.primaryColor.withOpacity(0.12),
                              AppColors.primaryColor.withOpacity(0.7),

                            ]),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ChatAvatarWidget(
                      color: AppColors.highlightColor,
                      child: Center(
                        child: forMe
                            ? Icon(
                                Icons.add,
                                color: AppColors.grey,
                              )
                            : Text(
                                userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.black,
                                    fontFamily: AppStrings.boldFontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: context.screenHeight * 0.02,
              width: context.screenWidth * 0.15,
              child: Text(
                forMe ? "Your Story" : userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.black,
                    fontFamily: AppStrings.boldFontFamily,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
