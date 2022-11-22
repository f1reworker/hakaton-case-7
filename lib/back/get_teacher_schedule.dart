import 'package:firebase_database/firebase_database.dart';
import 'package:hakaton_case_7/back/utils.dart';

// ignore: non_constant_identifier_names
Future<Map> get_teacher_schedule(String userId, String teacherId) async {
  final group =
      await FirebaseDatabase.instance.ref('users/${Utils.userId}/group').get();
  List? groups;
  if (group.value != null) {
    groups = (group.value! as String).split(', ');
  }
  if (groups != null && groups.isNotEmpty) {
    final result = await FirebaseDatabase.instance.ref('schedule').get();
    List sched;
    Map schedule = {};
    if (result.value != null) {
      sched = result.value as List;
    } else {
      return {};
    }
    for (var g in groups) {
      for (var t in sched[int.parse(g)].keys.toList()) {
        for (var l in sched[int.parse(g)][t].keys.toList()) {
          if (sched[int.parse(g)][t][l]['teacher'] == teacherId) {
            sched[int.parse(g)][t][l]['group'] = g;
            Map schInDay = schedule[t] ?? {};
            schInDay[l] = (sched[int.parse(g)][t][l]);
            schedule[t] = schInDay;
          }
        }
      }
    }
    return schedule;
  }
  return {};
}
