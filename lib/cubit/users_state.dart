import 'package:flutter/foundation.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersFetchFailed extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserInfo> users;

  UsersLoaded({required this.users});
}
