

import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat.dart';

class GetUserChatUseCase {
  final HomeRepository homeRepository ;

  GetUserChatUseCase(this.homeRepository);

  Future<Either<Failure , Stream<List<Chat>>>> call(User user)async => await  homeRepository.getUserChats(user);
}