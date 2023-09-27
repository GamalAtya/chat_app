import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';

class SendMSGWidget extends StatelessWidget {
  SendMSGWidget({Key? key , required this.user, required this.chatId}) : super(key: key);
  final TextEditingController messageController = TextEditingController();
  final User user ;
  final String? chatId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return SizedBox(
      height: size.height * 0.13,
      child: Padding(
        padding:  EdgeInsets.fromLTRB(20, 1, 25, size.height * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0 , 0 , 0.8 , 0),
              child: GestureDetector(
                onTap: (){
                  context.read<ChatBloc>().add(SendPhotoMessageEvent(receiver: user , chatId: chatId));
                },
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.add , size: 30, color:  AppColors.grey,),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  border: Border.all(color: Theme.of(context).canvasColor , width: 0.1),
                  borderRadius: BorderRadius.circular(8)
              ),
              height: size.height * 0.064,
              child: Row(
                children: [
                  SizedBox(
                    height: size.height * 0.064,
                    width: size.width * 0.8,
                    child: TextFormField(
                      controller: messageController,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                      ),
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              final chatBloc = BlocProvider.of<ChatBloc>(context);
                              final msg = Message(
                                  senderId: chatBloc.sender!.uid!,
                                  seen: false,
                                  time: Timestamp.now(),
                                  type: MsgType.text,
                                  content: messageController.text
                              );
                              chatBloc.add(SendMessageEvent(msg: msg, receiver: user , chatId: chatId));
                              messageController.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5 , 0 , 0),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: SvgPicture.asset(AppStrings.sendIcon),
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
