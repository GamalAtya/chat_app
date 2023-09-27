import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/core/image_picker/image_picker.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/home/data/models/chat_model.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/firebase_storage/firebase_storage.dart';
import '../../../../core/notifications/notifications.dart';

abstract class ChatRemoteDataSource {
  Future<String> sendMessage(MessageModel msg, UserModel sender,
      UserModel receiver, String? chatId);

  Future<String> sendPhotoMessage();

  Future<Stream<ChatModel>> getChatMessages(String? chatId, UserModel sender,
      UserModel receiver);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore fireStore;

  ChatRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<String> sendMessage(MessageModel msg, UserModel sender,
      UserModel receiver, String? chatId) async {
    if (chatId != null) {
      final oldChat =await getChatById(chatId);
      oldChat.messages.add(msg);
      final chatRef = await fireStore
          .collection(AppConstants.chatsCollection).doc(chatId).set(
          oldChat.toJson());
      await SendAppNotifications.sendNotificationToTopic(sender.uid!, "You Have New Message", msg.content);
      return chatId;
    } else {
      final Chat? chatRoom = await isThereOldChatBetweenUsers(sender, receiver);
      if (chatRoom != null) {
        final oldChat =await getChatById(chatRoom.chatId ?? "");
        oldChat.messages.add(msg);
        final chatRef = await fireStore
            .collection(AppConstants.chatsCollection).doc(chatRoom.chatId).set(
            oldChat.toJson());
        await SendAppNotifications.sendNotificationToTopic(sender.uid!, "You Have New Message", msg.content);
        return Future.value(chatRoom.chatId);
      } else {
        final chat = ChatModel(users: [sender, receiver], messages: [msg]);
        final chatRef = await fireStore
            .collection(AppConstants.chatsCollection)
            .add(chat.toJson());
        await SendAppNotifications.sendNotificationToTopic(sender.uid!, "You Have New Message", msg.content);
        return Future.value(chatRef.id);
      }
    }
  }

  @override
  Future<Stream<ChatModel>> getChatMessages(String? chatId, UserModel sender,
      UserModel receiver) async {
    if (chatId == null) {
      try {
        final Chat? chatRoom =
        await isThereOldChatBetweenUsers(sender, receiver);
        if (chatRoom != null) {
          final stream = fireStore
              .collection(AppConstants.chatsCollection)
              .doc(chatRoom.chatId)
              .snapshots(includeMetadataChanges: true)
              .map((event) => ChatModel.fromJson(event.data() ?? {} , chatId: chatRoom.chatId));
          return Future.value(stream);
        } else {
          throw EmptyCacheException();
        }
      } on Exception {
        throw EmptyCacheException();
      }
    }
    final stream = fireStore
        .collection(AppConstants.chatsCollection)
        .doc(chatId)
        .snapshots(includeMetadataChanges: true)
        .map((event) => ChatModel.fromJson(event.data() ?? {} , chatId: chatId));
    return Future.value(stream);
  }

  Future<ChatModel>  getChatById(String chatId)async{
    final chat = await fireStore
        .collection(AppConstants.chatsCollection)
        .doc(chatId)
        .get();
    final oldChat = ChatModel.fromJson(chat.data() ?? {});
    return oldChat ;
  }

  Future<Chat?> isThereOldChatBetweenUsers(UserModel sender,
      UserModel receiver) async {
    final chatRooms =
    await fireStore.collection(AppConstants.chatsCollection).get();
    final chats = List<ChatModel>.from(
        chatRooms.docs.map((e) => ChatModel.fromJson(e.data() , chatId: e.id)));
    final alreadyChatBefore = chats
        .where((element) =>
    element.users.contains(sender) && element.users.contains(receiver))
        .toList();
    if (alreadyChatBefore.isNotEmpty) {
      return alreadyChatBefore.first;
    }
    return null;
  }

  @override
  Future<String> sendPhotoMessage() async{
    try {
      final XFile? file = await AppImagePicker.pickImage();
      final String? url = await FirebaseStorageUploader.uploadFile(file);
      return url!;
    } on Exception {
      throw ServerException();
    }
  }
}
