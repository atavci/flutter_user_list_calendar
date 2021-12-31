import 'package:flutter/material.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/res/strings.dart';
import 'package:intl/intl.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;
  const UserInfoCard({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(userInfo.firstName + " " + userInfo.lastName),
            children: [
              ListTile(
                title: const Text(Strings.jobTitle),
                subtitle: Text(userInfo.jobTitle),
              ),
              ListTile(
                title: const Text(Strings.age),
                subtitle: Text(userInfo.age.toString()),
              ),
              ListTile(
                title: const Text(Strings.address),
                subtitle: Text(userInfo.address),
              ),
              ListTile(
                title: const Text(Strings.registeredDate),
                subtitle: Text(
                    DateFormat("dd/MM/yyyy").format(userInfo.registeredDate)),
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: Colors.black26),
        ),
      ),
    );
  }
}
