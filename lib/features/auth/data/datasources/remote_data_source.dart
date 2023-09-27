

import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {

  Future<UserModel> signInUser(UserModel model);

  Future<UserModel> signUpUser(UserModel model);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
   final FirebaseAuth auth ;
   final FirebaseFirestore fireStore ;
   AuthRemoteDataSourceImpl({required this.auth , required this.fireStore});

  @override
  Future<UserModel> signInUser(UserModel model) async{
    try{
      final cred =await auth.signInWithEmailAndPassword(email: model.email, password: model.password!);
      if(cred.user != null){
        final UserModel model = UserModel(
          uid: cred.user!.uid,
          email: cred.user!.email!,
          displayName: cred.user!.email!.split("@")[0],
        );
        return model ;
      }else{
        throw NotFoundException();
      }}on Exception {
       throw NotFoundException();
    }
  }

  @override
  Future<UserModel> signUpUser(UserModel model) async{
   try{
   final cred =await auth.createUserWithEmailAndPassword(email: model.email, password: model.password!);
   if(cred.user != null){
     final UserModel model = UserModel(
         uid: cred.user!.uid,
         email: cred.user!.email!,
         displayName: cred.user!.email!.split("@")[0],
     );
     await fireStore.collection(AppConstants.usersCollection).add(model.toJson());
     return model ;
   }else{
     throw ServerException();
   }}on Exception {
     throw ServerException();
   }
  }


}