


import 'package:chat_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required String email,  String? displayName,  String? password , String? uid}) :
        super(email: email, displayName: displayName , password: password , uid: uid);

  factory UserModel.fromUser(User user){
    if(user is UserModel){
      return user ;
    }
    return UserModel(email: user.email, displayName: user.displayName , uid: user.uid , password: user.password);
  }
  factory UserModel.fromJson(Map<String , dynamic> json)=> UserModel(
      email: json['email'],
      uid: json['uid'],
      displayName: json['displayName'],
      password: json['password']);

  Map<String , dynamic> toJson() => {
    "uid" : uid,
    "displayName" : displayName,
    "password" : password,
    "email" : email,
  };



}