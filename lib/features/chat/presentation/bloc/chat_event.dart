part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final User receiver ;
  final Message msg ;
  final String? chatId ;
  const SendMessageEvent({required this.receiver, required this.msg , required this.chatId});

  @override
  List<Object?> get props => [receiver, msg , chatId];
}

class SendPhotoMessageEvent extends ChatEvent {
  final User receiver ;
  final String? chatId ;
  const SendPhotoMessageEvent({required this.receiver,required this.chatId});

  @override
  List<Object?> get props => [receiver, chatId];
}


class GetChatMessages extends ChatEvent {
  final String? chatId ;
  final User receiver ;

  const GetChatMessages({required this.chatId , required this.receiver});

  @override
  List<Object?> get props => [chatId , receiver];
}




