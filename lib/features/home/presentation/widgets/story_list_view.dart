


import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/features/home/presentation/widgets/story_avatar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/contants/consts.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight * 0.133,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            AppConstants.outerPadding, 0, AppConstants.outerPadding, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            children: [
              const StoryAvatarWidget(forMe: true,),
              for (int i = 0; i < 100; i++)
              const StoryAvatarWidget(userName: "Gamal",),
            ],
          ),
        ),
      ),
    );
  }
}
