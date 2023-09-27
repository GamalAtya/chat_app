


import 'package:chat_app/core/enums/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String senderId;
  final Timestamp time ;
  final String content ;
  final MsgType? type ;
  final bool seen ;

  const Message({required this.senderId,required this.time,required this.content,required this.type,required this.seen});

  @override
  List<Object?> get props => [senderId,time,content,type,seen];

}