import 'package:firebase_database/firebase_database.dart';

// ignore: non_constant_identifier_names
Future<Map> get_schedule(String userId) async {
  final result = await FirebaseDatabase.instance.ref('schedule/$userId').get();
  Map sched;
  if (result.value != null) {
    sched = result.value as Map;
  } else {
    return {};
  }
  return sched;
}
