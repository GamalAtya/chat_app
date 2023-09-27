import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/chat.dart';

abstract class ChatRepository {

  Future<Either<Failure , String>> sendMessage(Message msg , User sender , User receiver , String? chatId);


  Future<Either<Failure, String>> uploadPhoto(User sender , User receiver, String? chatId);

  Future<Either<Failure, Stream<Chat>>> getChatMessagesStream(String? chatId,User sender , User receiver);
}