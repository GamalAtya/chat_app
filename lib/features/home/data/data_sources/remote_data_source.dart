import 'package:chat_app/core/contants/consts.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/home/data/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel> searchUsersByEmail(String email);

  Future<Stream<List<ChatModel>>> getUserChats(UserModel userModel);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore fireStore;
  HomeRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<UserModel> searchUsersByEmail(String email) async {
    final usersQuery = await fireStore
        .collection(AppConstants.usersCollection)
        .where("email", isEqualTo: email)
        .get();
    if (usersQuery.docs.isNotEmpty) {
      final user = UserModel.fromJson(usersQuery.docs[0].data());
      return Future.value(user);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Stream<List<ChatModel>>> getUserChats(UserModel userModel) async{
    return fireStore.collection(AppConstants.chatsCollection).snapshots().map(
             (event)  => event.docs.map((e) => ChatModel.fromJson(e.data() , chatId: e.id)).where((element) => element.users.contains(userModel)).toList());
  }
}
