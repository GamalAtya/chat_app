import 'dart:async';

import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:chat_app/features/chat/domain/use_cases/send_photo_msg_use_case.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../home/domain/use_cases/get_users_data_use_case.dart';
import '../../domain/use_cases/get_chat_msg_use_case.dart';
import '../../domain/use_cases/send_msg_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMsgUseCase sendMsgUseCase;
  final SendPhotoMsgUseCase photoMsgUseCase;
  final GetChatMsgUseCase getChatMsgUseCase;
  final GetUserDataUseCase getUserDataUseCase ;
  String? chatId;
  User? sender;
  ChatBloc({required this.sendMsgUseCase , required this.getChatMsgUseCase , required this.getUserDataUseCase , required this.photoMsgUseCase}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      try {
        if (event is GetChatMessages){
           final userOrFail = await getUserDataUseCase();
           userOrFail.fold((l) => l, (r) => sender = r);
          emit(LoadingChatMessages());
          final state = await getChatMessagesStream(event.chatId , sender! , event.receiver);
          emit(state);
        }
        if (event is SendMessageEvent) {
          final chatIdOrFail = await sendMsgUseCase(
            msg: event.msg,
            receiver: event.receiver,
            sender: sender!,
            chatId: event.chatId ?? chatId,
          );
          await chatIdOrFail.fold((l) => null, (r)async{
            if (event.chatId == null && chatId == null) {
              chatId = r;
              final chatMessagesState = await getChatMessagesStream(chatId , sender! , event.receiver);
              emit(chatMessagesState);
            }
          });
        }

        if (event is SendPhotoMessageEvent) {
          final chatIdOrFail = await photoMsgUseCase(
            receiver: event.receiver,
            sender: sender!,
            chatId: event.chatId ?? chatId,
          );
          await chatIdOrFail.fold((l) => null, (r)async{
            if (event.chatId == null && chatId == null) {
              chatId = r;
              final chatMessagesState = await getChatMessagesStream(chatId , sender! , event.receiver);
              emit(chatMessagesState);
            }
          });
        }
      } catch (e, stackTrace) {
        print('Error in ChatBloc: $e');
        print(stackTrace);
      }
    });


  }

  Future<ChatState> getChatMessagesStream(String? chatId , User sender , User receiver) async{
    final streamOrFail = await getChatMsgUseCase(chatId : chatId , sender: sender , receiver: receiver);
    return streamOrFail.fold((l) => ChatInitial(), (r) => LoadedChatMessages(chat: r));
  }

}

