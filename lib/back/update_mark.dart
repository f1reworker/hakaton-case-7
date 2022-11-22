import 'package:firebase_database/firebase_database.dart';

// ignore: non_constant_identifier_names
void update_mark(Map schedule) async {
  List lastSchedule;
  final result = await FirebaseDatabase.instance.ref('schedule').get();
  lastSchedule = result.value as List;
  for (var day in schedule.keys.toList()) {
    for (var time in schedule[day].keys.toList()) {
      lastSchedule[int.parse(schedule[day][time]['group'])][day][time] =
          schedule[day][time];
    }
  }
  FirebaseDatabase.instance.ref().update({'schedule': lastSchedule});
}
