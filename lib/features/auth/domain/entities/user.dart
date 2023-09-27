


import 'package:equatable/equatable.dart';

class User extends Equatable {

  final String email ;
  final String? password ;
  final String? displayName ;
  final String? uid ;


  const User({required this.email,this.displayName,this.uid ,this.password});

  @override
  List<Object?> get props =>[email , displayName , uid , password];
}