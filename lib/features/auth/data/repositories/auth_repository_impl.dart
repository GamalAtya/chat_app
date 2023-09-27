


import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/auth/data/datasources/local_data_source.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/remote_data_source.dart';
import '../models/user_model.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource ;
  final AuthLocalDataSource authLocalDataSource ;
  final NetworkInfo networkInfo ;


  AuthRepositoryImpl({required this.authRemoteDataSource,required this.networkInfo ,required this.authLocalDataSource, });

  @override
  Future<Either<Failure, Unit>> isLoggedIn() async{
    try{
      final userModel = await authLocalDataSource.getUserData();
      return const Right(unit);
    } on EmptyCacheException {
      return Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn(User user) async{
    if(!(await networkInfo.isConnected)){
      return Left(OfflineFailure());
    }
    try{
      final userModel = await authRemoteDataSource.signInUser(UserModel.fromUser(user));
      await authLocalDataSource.saveUserData(UserModel.fromUser(userModel));
      return const Right(unit);
    } on NotFoundException {
      return Left(NotFoundFailure());
    }
  }

  
  @override
  Future<Either<Failure, Unit>> signUp(User user) async{
      if(!(await networkInfo.isConnected)){
        return Left(OfflineFailure());
      }
      try{
        final userModel = await authRemoteDataSource.signUpUser(UserModel.fromUser(user));
        await authLocalDataSource.saveUserData(UserModel.fromUser(userModel));
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async{
    try {
      await authLocalDataSource.logOut();
      return const Right(unit);
    } on Exception {
      return Left(ServerFailure());
    }
  }
  
}