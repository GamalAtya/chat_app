

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../../auth/data/datasources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {

  final HomeRemoteDataSource homeRemoteDataSource ;
  final AuthLocalDataSource authLocalDataSource ;
  final NetworkInfo networkInfo ;

  HomeRepositoryImpl({required this.homeRemoteDataSource , required this.networkInfo , required this.authLocalDataSource});

  @override
  Future<Either<Failure, User>> searchUsersByEmail(String email) async{
    if(! await networkInfo.isConnected){
      return Left(OfflineFailure());
    }
    try {
      final user = await homeRemoteDataSource.searchUsersByEmail(email);
      return Right(User(email: user.email , uid: user.uid , displayName: user.displayName));

    } on Exception {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async{
    final user = await authLocalDataSource.getUserData();
    return Right(user);
  }

  @override
  Future<Either<Failure, Stream<List<Chat>>>> getUserChats(User user) async{
    if(! await networkInfo.isConnected){
      return Left(OfflineFailure());
    }
    return Right(await homeRemoteDataSource.getUserChats(UserModel.fromUser(user)));
  }

}