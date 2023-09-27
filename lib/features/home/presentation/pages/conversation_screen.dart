import 'package:chat_app/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../bloc/conversations_bloc/conversations_bloc.dart';
import '../widgets/chat_list_tile_widget.dart';
import '../widgets/home_screen_app_bar.dart';
import '../widgets/story_list_view.dart';
import '../../../../injection_container.dart' as di;


class ConversationScreen extends StatelessWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: HomeScreenAppBar(title: AppStrings.conversations),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const StoryListView(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Container(
                width: context.screenWidth * 0.872,
                height: context.screenHeight * 0.044,
                decoration: BoxDecoration(
                    color: AppColors.highlightColor,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppStrings.regularFontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
                        child: Icon(
                          Icons.search,
                          size: 25,
                          color: AppColors.grey,
                        ),
                      ),
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(
                          3, 0, AppConstants.outerPadding, 10),
                      enabledBorder: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      )),
                ),
              ),
            ),
            BlocBuilder<ConversationsBloc, ConversationsState>(
              builder: (context, state) {
                if (state is ConversationsLoading) {
                  return SizedBox(
                    height: context.screenHeight * 0.59,
                    child: const LoadingWidget(),
                  );
                }
                if (state is ConversationsLoaded) {
                  return SizedBox(
                      height: context.screenHeight * 0.59,
                      child: StreamBuilder(
                          stream: state.chats,
                          builder: (context, snapshot) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, i) {
                                  final chat = snapshot.data?[i];
                                  final user = context
                                      .read<ConversationsBloc>()
                                      .user;
                                  return GestureDetector(
                                    onTap: (){
                                      if(chat != null && chat.users.isNotEmpty){
                                      final receiver = chat.users.where((element) => element.uid != user?.uid).first;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) =>
                                              ChatPage(receiver: receiver, chatId: chat.chatId,)));}
                                    }
      ,
                                    child: ChatListTile(
                                      userName: chat?.users
                                          .where((element) =>
                                      element.uid != user?.uid)
                                          .first
                                          .displayName ??
                                          "",
                                      date: (chat?.messages.isNotEmpty ?? false)
                                          ? chat?.messages.last.time
                                          .toDate()
                                          .toLocal()
                                          .toString().split(" ")[0] ?? ""
                                          : "",
                                      lastMessage: (chat?.messages.isNotEmpty ??
                                          false) ? chat?.messages.last
                                          .content ?? "" : "",
                                      seen: false,
                                    ),
                                  );
                                });
                          }
                      ));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
