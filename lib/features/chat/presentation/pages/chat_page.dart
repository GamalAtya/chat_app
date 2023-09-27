import 'package:chat_app/core/colors/colors.dart';
import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/core/strings/app_strings.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/send_msg_widget.dart';
import '../../../../injection_container.dart' as di;

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.receiver, required this.chatId})
      : super(key: key);
  final User receiver;
  final String? chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) => di.sl<ChatBloc>()
        ..add(GetChatMessages(chatId: chatId, receiver: receiver)),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: ChatAppBarWidget(
              title:
                  receiver.displayName ?? receiver.email.split("@")[0] ?? ""),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is LoadedChatMessages) {
                      return SingleChildScrollView(
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StreamBuilder(
                              stream: state.chat,
                              builder: (context, snapShot) {
                                final List<Message> messages =
                                    snapShot.data?.messages ?? [];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    for (Message msg in messages)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment:
                                              msg.senderId == receiver.uid
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                          child: Column(
                                            crossAxisAlignment:
                                                msg.senderId == receiver.uid
                                                    ? CrossAxisAlignment.start
                                                    : CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: msg.senderId ==
                                                          receiver.uid
                                                      ? AppColors.white
                                                      : AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        context.screenWidth *
                                                            0.9),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      AppConstants
                                                          .innerPadding),
                                                  child: ((msg.type ??
                                                              MsgType.text) ==
                                                          MsgType.text)
                                                      ? Text(
                                                          msg.content,
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 18,
                                                            fontFamily: AppStrings
                                                                .boldFontFamily,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      : Container(
                                                          constraints: BoxConstraints(
                                                              minWidth: context.screenWidth * 0.3,
                                                              maxWidth: context.screenWidth * 0.3 ,
                                                              maxHeight: context.screenHeight * 0.3),
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      msg.content))),
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(msg.time
                                                    .toDate()
                                                    .toLocal()
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        msg.time.toDate().toLocal().
                                                        toString().length - 10)),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
                                );
                              }),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              SendMSGWidget(
                user: receiver,
                chatId: chatId,
              )
            ],
          ),
        );
      }),
    );
  }
}
