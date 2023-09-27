

import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../chat/domain/entities/message.dart';

class Chat extends Equatable {
  late String? chatId ;
  final List<User> users ;
  late final List<Message> messages ;


   Chat({required this.users,required this.messages , this.chatId});


  @override
  List<Object?> get props => [users , messages , chatId];
}