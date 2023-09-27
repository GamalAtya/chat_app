part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  final int tabIndex ;
  const HomeScreenState({required this.tabIndex});
}

class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial({required super.tabIndex});
  @override
  List<Object> get props => [tabIndex];
}

class LogOutState extends HomeScreenState {
  const LogOutState():super(tabIndex: 1);
  @override
  List<Object> get props => [];
}

class HomeScreenLoading extends HomeScreenState {
  const HomeScreenLoading(): super(tabIndex: 0);
  @override
  List<Object> get props => [];
}

class SearchUserByEmailState extends HomeScreenState {
  const SearchUserByEmailState({required this.user}):super(tabIndex: 0);
  final User user ;
  @override
  List<Object> get props => [user];
}


class UserChatsLoaded extends HomeScreenState{
  final List<Chat> chats ;

  const UserChatsLoaded({required this.chats}):super(tabIndex: 1);

  @override
  List<Object?> get props => [chats];

}
