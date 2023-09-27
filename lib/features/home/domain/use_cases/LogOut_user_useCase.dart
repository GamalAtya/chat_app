

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOutUserUseCase {
  final AuthRepository authRepository ;

  LogOutUserUseCase(this.authRepository);

  Future<Either<Failure , Unit>> call()async => await authRepository.logOut();
}