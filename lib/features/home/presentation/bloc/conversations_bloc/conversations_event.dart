part of 'conversations_bloc.dart';

abstract class ConversationsEvent extends Equatable {
  const ConversationsEvent();
}

class GetUserChatsEvent extends ConversationsEvent{
  @override
  List<Object?> get props => [];

}


