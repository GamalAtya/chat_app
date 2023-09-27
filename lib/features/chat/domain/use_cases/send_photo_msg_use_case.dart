


import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/chat.dart';
import '../entities/message.dart';

class SendPhotoMsgUseCase {
  final ChatRepository chatRepository ;

  SendPhotoMsgUseCase({required this.chatRepository});

  Future<Either<Failure , String>> call({required User sender ,required User receiver , required String? chatId}) async => await chatRepository.uploadPhoto(sender , receiver , chatId);
}