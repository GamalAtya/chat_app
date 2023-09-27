



import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserDataUseCase {
  final HomeRepository homeRepository ;

  GetUserDataUseCase({required this.homeRepository});

  Future<Either<Failure , User>> call()async => await homeRepository.getUser();
}