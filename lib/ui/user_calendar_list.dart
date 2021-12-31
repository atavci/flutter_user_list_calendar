import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_list_calendar/cubit/users_cubit.dart';
import 'package:flutter_user_list_calendar/cubit/users_state.dart';
import 'package:flutter_user_list_calendar/model/user_info.dart';
import 'package:flutter_user_list_calendar/res/strings.dart';
import 'package:flutter_user_list_calendar/res/styles.dart';
import 'package:flutter_user_list_calendar/ui/custom_search_delegate.dart';
import 'package:flutter_user_list_calendar/ui/user_info_card.dart';
import 'package:flutter_user_list_calendar/util/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class UserCalendarList extends StatefulWidget {
  const UserCalendarList({Key? key}) : super(key: key);

  @override
  _UserCalendarListState createState() => _UserCalendarListState();
}

class _UserCalendarListState extends State<UserCalendarList> {
  late UsersCubit _usersCubit;
  late final ValueNotifier<List<UserInfo>> _selectedEvents;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _usersCubit = BlocProvider.of<UsersCubit>(context);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
        BlocProvider.of<UsersCubit>(context).getEventsForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value =
          BlocProvider.of<UsersCubit>(context).getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.userCalendarListTitle,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch<List<UserInfo>>(
                context: context,
                delegate: CustomSearchDelegate(_usersCubit),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return Column(
              children: [
                TableCalendar<UserInfo>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  availableCalendarFormats: const {
                    CalendarFormat.month: "Month"
                  },
                  eventLoader:
                      BlocProvider.of<UsersCubit>(context).getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: lightGreen, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                      color: grassGreen,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                  ),
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: ValueListenableBuilder<List<UserInfo>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      if (value.isEmpty) {
                        return const Center(
                          child: Text(Strings.userNotFound),
                        );
                      }
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return UserInfoCard(
                            userInfo: value[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is UsersFetchFailed) {
            return const Center(
              child: Text(Strings.usersFetchFailedMessage),
            );
          }
          // Initial State
          else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }
}
