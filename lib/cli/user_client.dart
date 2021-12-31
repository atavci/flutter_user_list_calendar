import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/res/app_config.dart';
import 'package:http/http.dart' as http;

class UserClient {
  http.Client defaultCli = http.Client();

  Future<List<UserInfo>> fetchUsersData({http.Client? client}) async {
    if (client != null) {
      defaultCli = client;
    }

    http.Response response = await defaultCli.get(Uri.parse(endpoint));
    if (response.statusCode >= 400) {
      debugPrint("Fetch Users failed.");
      return [];
    }

    if (response.body.isNotEmpty) {
      List<dynamic> users = jsonDecode(response.body);
      List<UserInfo> userInfos = [];
      for (final element in users) {
        {
          userInfos.add(UserInfo.fromMap(Map<String, dynamic>.from(element)));
        }
      }
      return userInfos;
    }

    return [];
  }
}
