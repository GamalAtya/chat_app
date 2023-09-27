


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/strings/app_strings.dart';
import 'chat_avatar_widget.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({Key? key ,
    required this.userName,
    required this.lastMessage,
    required this.date,
    this.seen = false ,
    this.hideSeen = false,
    this.messagesNumber = 1
  }) : super(key: key);

  final String userName ;
  final String lastMessage ;
  final String date ;
  final bool seen ;
  final bool hideSeen ;
  final int messagesNumber ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        leading: ChatAvatarWidget(color: AppColors.primaryColor ,
            child:  Center(
              child: Text( userName.toUpperCase().substring(0 , 3) ,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: AppStrings.boldFontFamily,
                  fontWeight: FontWeight.w800,
                ),
              ),)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0 , 10 , 0 , 0 ),
              child: Text(
                userName ,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: AppStrings.boldFontFamily,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0 , 10 , 0 , 12 ),
              child: Text(
                lastMessage ,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.boldFontFamily,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        trailing: hideSeen ? const SizedBox.shrink() : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date ,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.grey,
                fontFamily: AppStrings.regularFontFamily,
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: seen ? Colors.transparent :AppColors.primaryColor.withOpacity(0.50),
                  shape: BoxShape.circle
              ),
              child: Center(
                child: seen ? SvgPicture.asset(AppStrings.seenIcon) : Text(
                  messagesNumber.toString() ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                    fontFamily: AppStrings.boldFontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
