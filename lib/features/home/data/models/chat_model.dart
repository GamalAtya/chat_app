import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/domain/entities/message.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chat {
  ChatModel(
      {String? chatId,
      required List<UserModel> users,
      required List<MessageModel> messages})
      : super(messages: messages, users: users, chatId: chatId);

  factory ChatModel.fromChat(Chat chat) {
    if (chat is ChatModel) {
      return chat;
    }
    return ChatModel(
        chatId: chat.chatId,
        users:
            List<UserModel>.from(chat.users.map((e) => UserModel.fromUser(e))),
        messages: List<MessageModel>.from(
            chat.messages.map((e) => MessageModel.fromMessage(e))));
  }

  factory ChatModel.fromJson(Map<String, dynamic> json, {String? chatId}) =>
      ChatModel(
          chatId: chatId,
          users: List<UserModel>.from(
              json["users"].map((e) => UserModel.fromJson(e))),
          messages: List<MessageModel>.from(
              json["messages"].map((e) => MessageModel.fromJson(e))));


  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "users": users.map((e) => UserModel.fromUser(e).toJson()).toList(),
        "messages":
            messages.map((e) => MessageModel.fromMessage(e).toJson()).toList()
      };



}
