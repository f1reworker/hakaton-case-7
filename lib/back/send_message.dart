import 'package:cloud_firestore/cloud_firestore.dart';

Future createDialog(
  String toUser,
  String fromUser,
) async {
  FirebaseFirestore.instance
      .collection('chats$fromUser')
      .doc(toUser)
      .get()
      .then((value) {
    if (value.data() == null) {
      FirebaseFirestore.instance
          .collection('chats$fromUser')
          .doc(toUser)
          .set({});
      FirebaseFirestore.instance
          .collection('chats$toUser')
          .doc(fromUser)
          .set({});
    }
  });
}

Future sendMessage(
  String toUser,
  String fromUser,
  String? attachments,
  String? text,
  int time,
) async {
  final dbRefFrom =
      FirebaseFirestore.instance.collection('chats$fromUser').doc(toUser);
  final int id = await FirebaseFirestore.instance
      .collection('chats$fromUser')
      .doc(toUser)
      .get()
      .then((value) {
    return value.data() == null ? 0 : value.data()!.length;
  });
  dbRefFrom.update({
    id.toString(): {
      'attachments': attachments,
      'from_me': true,
      'text': text,
      'time': time,
      'view': false,
    }
  });
  final dbRefTo =
      FirebaseFirestore.instance.collection('chats$toUser').doc(fromUser);
  dbRefTo.update({
    id.toString(): {
      'attachments': attachments,
      'from_me': false,
      'text': text,
      'time': time,
      'view': false,
    }
  });
}

Future updateMessage(
  String toUser,
  String fromUser,
  String? attachments,
  String? text,
  int time,
  String id,
) async {
  final dbRefFrom =
      FirebaseFirestore.instance.collection('chats$fromUser').doc(toUser);
  dbRefFrom.update({
    id: {
      'attachments': attachments,
      'from_me': true,
      'text': text,
      'time': time,
      'view': true,
    }
  });
  final dbRefTo =
      FirebaseFirestore.instance.collection('chats$toUser').doc(fromUser);
  dbRefTo.update({
    id: {
      'attachments': attachments,
      'from_me': false,
      'text': text,
      'time': time,
      'view': true,
    }
  });
}
