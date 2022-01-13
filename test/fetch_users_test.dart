import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_list_calendar/cli/user_client.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/util/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  final List<Map> mockUsers = [
    UserInfo(1, 79, "Jeffersonville, Indiana, United States", "Eagell", "Ivar",
            "Outbound BDR", parseApiDateTime("Dec 24, 2021 9:19 PM"))
        .toMap(),
    UserInfo(2, 9, "Peoria, Arizona, United States", "O'Hengerty", "Micah",
            "Product Manager", parseApiDateTime("Nov 28, 2021 9:29 PM"))
        .toMap(),
  ];
  test('returns list of users if successfull', () async {
    final client = MockClient(
        (request) async => http.Response(jsonEncode(mockUsers), 200));

    expect(await UserClient().fetchUsersData(client: client),
        isA<List<UserInfo>>());
  });
}
