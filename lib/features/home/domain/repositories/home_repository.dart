

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:dartz/dartz.dart';

import '../../../auth/domain/entities/user.dart';

abstract class HomeRepository {

  Future<Either<Failure , User>> searchUsersByEmail(String email);

  Future<Either<Failure , User>> getUser();


  Future<Either<Failure , Stream<List<Chat>>>> getUserChats(User user);

}