import 'package:firebase_database/firebase_database.dart';

Future<Map> getArticles() async {
  final result = await FirebaseDatabase.instance.ref('articles').get();
  Map sched;
  if (result.value != null) {
    sched = result.value as Map;
  } else {
    return {};
  }
  return sched;
}
