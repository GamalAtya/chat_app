


import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/chat.dart';
import '../entities/message.dart';

class GetChatMsgUseCase {
  final ChatRepository chatRepository ;

  GetChatMsgUseCase({required this.chatRepository});

  Future<Either<Failure, Stream<Chat>>> call({required String? chatId ,required User sender,required User receiver }) async => await chatRepository.getChatMessagesStream(chatId , receiver , sender);
}