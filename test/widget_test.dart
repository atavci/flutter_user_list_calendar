// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_list_calendar/cli/user_client.dart';
import 'package:flutter_user_list_calendar/cubit/users_cubit.dart';
import 'package:flutter_user_list_calendar/main.dart';
import 'package:flutter_user_list_calendar/res/strings.dart';

void main() {
  testWidgets('App Title Smoke Testing', (WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider(
        create: (_) => UsersCubit(client: UserClient()), child: const MyApp()));

    // Check for the app title.
    expect(find.text(Strings.userCalendarListTitle), findsOneWidget);

    // Tap the search icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Expect to find search page title.
    expect(find.text(Strings.userCalendarListTitle), findsOneWidget);
  });
}
