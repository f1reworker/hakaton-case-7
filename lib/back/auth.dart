import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hakaton_case_7/back/send_message.dart';
import 'package:hakaton_case_7/back/upload_picture.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

Future register(
  String login,
  String password,
  int age,
  XFile? avatar,
  String school,
  String name,
  String surname,
  String type,
  String relative,
) async {
  try {
    final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: login, password: password);
    String? linkAv;
    if (avatar != null) {
      linkAv = await uploadFile(avatar.name, avatar.path, 'users');
    }
    await FirebaseFirestore.instance
        .collection('chats${result.user!.uid}')
        .doc('2bsIaaENPwPabfsezDWJLiqNEvQ2')
        .set({});
    await FirebaseFirestore.instance
        .collection('chats2bsIaaENPwPabfsezDWJLiqNEvQ2')
        .doc(result.user!.uid)
        .set({});
    sendMessage(
        result.user!.uid,
        '2bsIaaENPwPabfsezDWJLiqNEvQ2',
        null,
        'Отвечу на все интересующие Вас вопросы',
        (DateTime.now().millisecondsSinceEpoch / 1000).ceil());
    await FirebaseDatabase.instance.ref('users/${result.user!.uid}').set({
      'age': age,
      'ava': linkAv,
      'email': login,
      'name': name,
      'relative': relative,
      'school': school,
      'surname': surname,
      'type': type,
      'group': null
    });
    await FirebaseFirestore.instance
        .collection('currency')
        .doc(result.user!.uid)
        .set({'how': 10});
    return result.user!.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 1;
    } else if (e.code == 'invalid-email') {
      return 2;
    } else if (e.code == 'email-already-in-use') {
      return 0;
    }
  } catch (e) {
    return -1;
  }
}

Future login(String login, String password) async {
  try {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: login, password: password);
    return result.user!.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      return 0;
    } else {
      return -1;
    }
  }
}
