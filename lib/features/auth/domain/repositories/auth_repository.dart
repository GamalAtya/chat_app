


import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure , Unit>> signUp(User user);

  Future<Either<Failure , Unit>> signIn(User user);

  Future<Either<Failure , Unit>> isLoggedIn();

  Future<Either<Failure , Unit>> logOut();
}