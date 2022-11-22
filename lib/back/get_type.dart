import 'package:firebase_database/firebase_database.dart';
import 'package:hakaton_case_7/back/utils.dart';

// ignore: non_constant_identifier_names
Future get_type() async {
  late String type;
  var data =
      await FirebaseDatabase.instance.ref('users/${Utils.userId}/type').get();
  type = data.value as String;
  return type;
}
