

import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MessageModel extends Message {
  const MessageModel({
    required String senderId,
    required Timestamp time,
    required String content,
    required MsgType? type,
    required bool seen}): super(content: content , type: type , time: time , seen: seen , senderId: senderId);

  factory MessageModel.fromMessage(Message message){
    if(message is MessageModel){
      return message ;
    }
    return MessageModel(
        senderId: message.senderId,
        time: message.time,
        content: message.content,
        type: message.type,
        seen: message.seen);
  }


  factory MessageModel.fromJson(Map<String , dynamic> json) => MessageModel(
    senderId: json["senderId"],
    time: json["time"],
    content: json["content"],
    seen: json["seen"],
    type: json["type"] != "null" &&  json["type"] != null ? msgTypeFromJson(json["type"]) : null
  );

  Map<String , dynamic> toJson() => {
    "senderId" : senderId ,
    "time" : time ,
    "content" : content ,
    "type" : type.toString(),
    "seen" : seen ,
  };
}