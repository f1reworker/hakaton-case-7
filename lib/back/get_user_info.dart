import 'package:firebase_database/firebase_database.dart';

// ignore: non_constant_identifier_names
Future get_user_info(String id) async {
  Map user;
  final result = await FirebaseDatabase.instance.ref('users/$id').get();
  user = result.value as Map;
  return user;
}
