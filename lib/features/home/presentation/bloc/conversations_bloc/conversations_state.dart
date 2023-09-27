part of 'conversations_bloc.dart';

abstract class ConversationsState extends Equatable {
  const ConversationsState();
}

class ConversationsInitial extends ConversationsState {
  @override
  List<Object> get props => [];
}


class ConversationsLoading extends ConversationsState {
  @override
  List<Object> get props => [];
}


class ConversationsLoaded extends ConversationsState {
  final Stream<List<Chat>> chats ;

  const ConversationsLoaded({required this.chats});

  @override
  List<Object> get props => [];
}