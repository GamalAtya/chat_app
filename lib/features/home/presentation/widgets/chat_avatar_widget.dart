import 'package:chat_app/core/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';

class ChatAvatarWidget extends StatelessWidget {
  const ChatAvatarWidget({Key? key , required this.color , required this.child}) : super(key: key);
  final Color color ;
  final Widget child ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.06,
      width: context.screenWidth * 0.128,
      decoration: BoxDecoration(
          color: color,
          borderRadius:
          BorderRadius.circular(20)),
      child: child,
    );
  }
}
