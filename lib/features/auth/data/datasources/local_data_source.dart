

import 'dart:convert';

import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<Unit>  saveUserData(UserModel user);
  Future<UserModel> getUserData();
  Future<Unit> logOut();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final SharedPreferences preferences ;
  const AuthLocalDataSourceImpl(this.preferences);

  @override
  Future<UserModel> getUserData() async{
   final stringUser = preferences.getString(AppConstants.userDataKey);
   if(stringUser == null){
     throw EmptyCacheException();
   }
   final jsonUser = json.decode(stringUser);
   final user = UserModel.fromJson(jsonUser);
   return Future.value(user);
  }

  @override
  Future<Unit> saveUserData(UserModel user) async {
    await preferences.setString(AppConstants.userDataKey, jsonEncode(user.toJson()));
    return unit ;
  }

  @override
  Future<Unit> logOut() async{
   await preferences.remove(AppConstants.userDataKey);
   return unit ;
  }

}