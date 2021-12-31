import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_user_list_calendar/util/utils.dart';

class UserInfo {
  final int id;
  final int age;
  final String address;
  final String lastName;
  final String firstName;
  final String jobTitle;
  final DateTime registeredDate;

  String get fullName => firstName + " " + lastName;

  UserInfo(this.id, this.age, this.address, this.lastName, this.firstName,
      this.jobTitle, this.registeredDate);

  factory UserInfo.fromMap(final Map<String, dynamic> userInfoMap) {
    if (userInfoMap['id'] == null) {
      debugPrint(
          "UserID not found! instance should not be instantiated. Assigning default id '-1' ");
      userInfoMap['id'] = -1;
    }

    // Keys below are defined corresponding with the api.
    return UserInfo(
      userInfoMap['id'],
      userInfoMap['age'] ?? '0',
      userInfoMap['address'] ?? '',
      userInfoMap['lastname'] ?? '',
      userInfoMap['firstname'] ?? '',
      userInfoMap['job_title'] ?? '',
      userInfoMap['registered_date'] != null
          ? parseApiDateTime(userInfoMap['registered_date'])
          : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory UserInfo.fromJson(final String json) {
    Map<String, dynamic> userInfoMap = jsonDecode(json);
    return UserInfo.fromMap(userInfoMap);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'age': age,
      'address': address,
      'lastname': lastName,
      'firstname': firstName,
      'job_title': jobTitle,
      'registered_date': registeredDate.toString()
    };
  }

  @override
  String toString() {
    return 'id: $id, name:$firstName $lastName, age: $age, address: $address, jobTitle: $jobTitle, registeredDate:$registeredDate';
  }
}
