import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_list_calendar/cubit/users_cubit.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/ui/user_info_card.dart';

class CustomSearchDelegate extends SearchDelegate<List<UserInfo>> {
  final UsersCubit usersCubit;

  CustomSearchDelegate(this.usersCubit);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserInfo> searchResult = usersCubit.searchUsers(query);
    return BlocProvider<UsersCubit>(
      create: (_) => usersCubit,
      child: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (_, i) {
          var userResult = searchResult[i];
          return UserInfoCard(userInfo: userResult);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
