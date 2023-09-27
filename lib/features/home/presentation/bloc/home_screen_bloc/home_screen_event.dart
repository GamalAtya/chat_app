part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class GetUserDataEvent extends HomeScreenEvent{
  const GetUserDataEvent();
  @override
  List<Object?> get props => [];
}

class ChangeHomeTabEvent extends HomeScreenEvent{
  final int tabIndex ;

  const ChangeHomeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];

}

class SearchUserByEmailEvent extends HomeScreenEvent{
  final String email ;

  const SearchUserByEmailEvent(this.email);

  @override
  List<Object?> get props => [email];

}

class LogOutEvent extends HomeScreenEvent{
  @override
  List<Object?> get props => [];
}
