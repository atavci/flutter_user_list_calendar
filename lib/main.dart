import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_list_calendar/cli/user_client.dart';
import 'package:flutter_user_list_calendar/cubit/users_cubit.dart';
import 'package:flutter_user_list_calendar/res/strings.dart';
import 'package:flutter_user_list_calendar/ui/user_calendar_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (_) => UsersCubit(client: UserClient()),
        child: const UserCalendarList(),
      ),
    );
  }
}
