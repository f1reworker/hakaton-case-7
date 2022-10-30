import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/send_message.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatelessWidget {
  final String withUser;
  const MessagePage({Key? key, required this.withUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats${Utils.userId!}')
            .doc(withUser)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            final Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final Map<String, dynamic> messages = data;

            return SizedBox(
              height: MediaQuery.of(context).size.height - 170,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (index > 0 &&
                        !messages[(index - 1).toString()]['from_me']) {
                      updateMessage(
                          Utils.userId!,
                          withUser,
                          messages[(index - 1).toString()]['attachments'],
                          messages[(index - 1).toString()]['text'],
                          messages[(index - 1).toString()]['time'],
                          (index - 1).toString());
                    }
                    return index == 0
                        ? const SizedBox(
                            height: 20,
                          )
                        : messages[(index - 1).toString()]['attachments'] !=
                                null
                            ? messages[(index - 1).toString()]['from_me']
                                ? buildAttachMe(
                                    messages[(index - 1).toString()],
                                    context,
                                    messages[index.toString()] == null
                                        ? true
                                        : !messages[index.toString()]
                                            ['from_me'])
                                : buildAttachYou(
                                    messages[(index - 1).toString()],
                                    context,
                                    messages[index.toString()] == null
                                        ? true
                                        : !messages[index.toString()]
                                            ['from_me'])
                            : messages[(index - 1).toString()]['from_me']
                                ? buildMessageMe(
                                    messages[(index - 1).toString()],
                                    context,
                                    messages[index.toString()] == null
                                        ? true
                                        : !messages[index.toString()]
                                            ['from_me'])
                                : buildMessageYou(
                                    messages[(index - 1).toString()],
                                    context,
                                    messages[index.toString()] == null
                                        ? true
                                        : !messages[index.toString()]
                                            ['from_me']);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(),
                  itemCount: messages.length + 1),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildAttachMe(Map mes, BuildContext context, bool next) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(children: [
        Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Image.network(
                mes['attachments'],
                fit: BoxFit.fitHeight,
              ),
            )),
        next
            ? Align(
                alignment: Alignment.centerRight,
                child: Text(DateFormat('HH:mm')
                    .format(
                        DateTime.fromMillisecondsSinceEpoch(mes['time'] * 1000))
                    .toString()),
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget buildAttachYou(Map mes, BuildContext context, bool next) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Image.network(
                mes['attachments'],
                fit: BoxFit.fitHeight,
              ),
            )),
        next
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(DateFormat('HH:mm')
                    .format(
                        DateTime.fromMillisecondsSinceEpoch(mes['time'] * 1000))
                    .toString()),
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget buildMessageMe(Map mes, BuildContext context, bool next) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(children: [
        Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(mes['text']),
              ),
            )),
        next
            ? Align(
                alignment: Alignment.centerRight,
                child: Text(DateFormat('HH:mm')
                    .format(
                        DateTime.fromMillisecondsSinceEpoch(mes['time'] * 1000))
                    .toString()),
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget buildMessageYou(Map mes, BuildContext context, bool next) {
    return Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12, top: 12, left: 6, right: 13),
                    child: Text(mes['text']),
                  ),
                )),
            next
                ? Align(
                    //TODO: Разобраться со временем, кинуть его вправо
                    alignment: Alignment.bottomLeft,
                    child: Text(DateFormat('HH:mm')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            mes['time'] * 1000))
                        .toString()),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
