


import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../home/domain/entities/chat.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final NetworkInfo networkInfo ;


  ChatRepositoryImpl({required this.chatRemoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, String>> sendMessage(Message msg, User sender , User receiver, String? chatId) async{
    if(!await networkInfo.isConnected){
      return Left(OfflineFailure());
    }

    final _chatId = await chatRemoteDataSource.sendMessage(MessageModel.fromMessage(msg), UserModel.fromUser(sender) ,  UserModel.fromUser(receiver) , chatId);
    return Right(_chatId);
  }

  @override
  Future<Either<Failure, Stream<Chat>>> getChatMessagesStream(String? chatId ,User sender , User receiver) async{
    if(!await networkInfo.isConnected){
      return Left(OfflineFailure());
    }
    try{
      return Right(await chatRemoteDataSource.getChatMessages(chatId , UserModel.fromUser(sender) ,  UserModel.fromUser(receiver)));
    }on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadPhoto(User sender , User receiver, String? chatId) async{
    try{
      final String url = await chatRemoteDataSource.sendPhotoMessage();
      final Message msg = Message(
          senderId: sender.uid!,
          seen: false,
          type: MsgType.photo,
          time: Timestamp.now(),
          content: url);
      final _chatId = await chatRemoteDataSource.sendMessage(MessageModel.fromMessage(msg), UserModel.fromUser(sender) ,  UserModel.fromUser(receiver) , chatId);
      return Right(_chatId);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}