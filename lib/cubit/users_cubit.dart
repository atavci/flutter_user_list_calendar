import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_list_calendar/cli/user_client.dart';
import 'package:flutter_user_list_calendar/cubit/users_state.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/util/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserClient client;

  final LinkedHashMap<DateTime, List<UserInfo>> userDateMap =
      LinkedHashMap(equals: isSameDay, hashCode: getHashCode);

  final List<UserInfo> _users = [];

  List<UserInfo> get users => _users;

  UsersCubit({required this.client}) : super(UsersInitial()) {
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<UserInfo> fetchedUsers = await client.fetchUsersData();
    if (fetchedUsers.isNotEmpty) {
      // Remove nullable ids
      fetchedUsers = fetchedUsers.where((k) => k.id != -1).toList();
      _users.addAll(fetchedUsers);
      _generateUserDateMap(_users);
      emit(UsersLoaded(users: _users));
    } else {
      emit(UsersFetchFailed());
    }
  }

  void _generateUserDateMap(List<UserInfo> users) {
    for (UserInfo user in users) {
      if (userDateMap.containsKey(user.registeredDate)) {
        List<UserInfo> existedUsers = userDateMap[user.registeredDate] ?? [];
        existedUsers.add(user);
        userDateMap.update(user.registeredDate, (value) => existedUsers);
      } else {
        userDateMap.putIfAbsent(user.registeredDate, () => [user]);
      }
    }
  }

  List<UserInfo> getEventsForDay(DateTime day) {
    return userDateMap[day] ?? [];
  }

  List<UserInfo> searchUsers(String query) {
    List<UserInfo> searchResult = [];
    if (query.isNotEmpty && query.length >= 2) {
      if (query.split(" ").length > 1) {
        final searchQuery = query.replaceAll(" ", "").toLowerCase();
        for (var user in users) {
          if (user.fullName
              .replaceAll(" ", "")
              .toLowerCase()
              .contains(searchQuery)) {
            if (!searchResult.contains(user)) {
              searchResult.add(user);
            }
          }
        }
      } else {
        for (var user in users) {
          if (user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.lastName.toLowerCase().contains(query.toLowerCase())) {
            if (!searchResult.contains(user)) {
              searchResult.add(user);
            }
          }
        }
      }
    } else {
      searchResult = users;
    }
    return searchResult;
  }
}
