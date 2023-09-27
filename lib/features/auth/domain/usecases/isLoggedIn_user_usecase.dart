

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class IsLoggedInUserUseCase {

  final AuthRepository authRepository ;

  IsLoggedInUserUseCase({required this.authRepository});

  Future<Either<Failure , Unit>> call() async => await authRepository.isLoggedIn();
}