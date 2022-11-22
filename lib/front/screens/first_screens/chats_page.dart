import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/send_message.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/second_screens/dialog_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List _chats = [];
  final Map _chatsData = {};
  Map? allUsers;
  bool search = false;
  String? ava;
  void getAllUsers() {
    FirebaseDatabase.instance.ref('users').get().then((value) => setState(() {
          allUsers = value.value as Map;
          allUsers!.remove(Utils.userId!);
        }));
  }

  void changeSearch() {
    setState(() {
      search = !search;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('chats${Utils.userId!}')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data().isNotEmpty) {
          _chats.add(element.id);
        }
      }
      updateChats();
      getAllUsers();
    });
    FirebaseDatabase.instance
        .ref("users/${Utils.userId}/ava")
        .get()
        .then((value) {
      ava = value.value.toString();
      setState(() {});
    });
  }

  void updateChats() {
    for (var element in _chats) {
      FirebaseDatabase.instance.ref('users').get().then((value) {
        if (value.value != null) {
          Map vals = value.value as Map;

          _chatsData[element] = vals[element];
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                      color: CustomColors.indigo),
                  child: TextButton(
                    onPressed: changeSearch,
                    child: Icon(
                      Icons.search,
                      color: CustomColors.white,
                    ),
                  ),
                ), //TODO: иконка
                Text('Чаты',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.indigo)),
                ava == null
                    ? Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(22)),
                            color: CustomColors.gray),
                      )
                    : Container(
                        width: 44,
                        height: 44.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(ava!))))
              ],
            ),
          ),
          !search
              ? _chatsData.isNotEmpty && _chats.length == _chatsData.length
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _chats.length,
                      itemBuilder: (BuildContext context, index) {
                        return TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          DialogPage(
                                    withUser: _chats[index],
                                    user: _chatsData[_chats[index]],
                                  ),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ));
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 27, right: 22),
                              child: SizedBox(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width - 54,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 52,
                                          height: 52.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      _chatsData[_chats[index]]
                                                          ['ava'])))),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              '${_chatsData[_chats[index]]["name"]} ${_chatsData[_chats[index]]["surname"]}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: CustomColors.indigo)),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(
                                                      'chats${Utils.userId}')
                                                  .doc(_chats[index])
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snap) {
                                                if (snap.hasData &&
                                                    snap.data!.data() != null) {
                                                  final Map<String, dynamic>
                                                      dataMes =
                                                      snap.data!.data() as Map<
                                                          String, dynamic>;
                                                  if (dataMes.isNotEmpty) {
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              145,
                                                      child: Text(
                                                          dataMes[(dataMes.length - 1)
                                                                          .toString()][
                                                                      'text'] ==
                                                                  ""
                                                              ? 'Вложение'
                                                              : dataMes[(dataMes.length - 1)
                                                                      .toString()]
                                                                  ['text'],
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  CustomColors
                                                                      .gray)),
                                                    );
                                                  }
                                                }
                                                return const SizedBox(
                                                  height: 12,
                                                );
                                              }),
                                        ],
                                      ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection(
                                                  'chats${Utils.userId}')
                                              .doc(_chats[index])
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snap) {
                                            if (snap.hasData &&
                                                snap.data!.data() != null) {
                                              final Map<String, dynamic>
                                                  dataMes = snap.data!.data()
                                                      as Map<String, dynamic>;
                                              if (dataMes.isNotEmpty) {
                                                int unread = 0;
                                                for (int i = 0;
                                                    i < dataMes.length;
                                                    i++) {
                                                  if (dataMes[i.toString()]
                                                              ['view'] ==
                                                          false &&
                                                      !dataMes[i.toString()]
                                                          ['from_me']) {
                                                    unread++;
                                                  }
                                                }
                                                if (unread != 0) {
                                                  return Container(
                                                    height: 22,
                                                    width: 22,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomColors
                                                            .orange),
                                                    child: Center(
                                                      child: Text(
                                                          unread.toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  CustomColors
                                                                      .white)),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              } else {
                                                return const SizedBox();
                                              }
                                            } else {
                                              return const SizedBox();
                                            }
                                          })
                                    ],
                                  ))),
                        );
                      })
                  : const SizedBox()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          height: 60,
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            onPressed: () {
                              createDialog(allUsers!.keys.toList()[index],
                                      Utils.userId!)
                                  .then((value) => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                DialogPage(
                                          user: allUsers![
                                              allUsers!.keys.toList()[index]],
                                          withUser:
                                              allUsers!.keys.toList()[index],
                                        ),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      )));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(allUsers![
                                              allUsers!.keys
                                                  .toList()[index]]['ava']))),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  allUsers![allUsers!.keys.toList()[index]]
                                          ['name'] +
                                      ' ' +
                                      allUsers![allUsers!.keys.toList()[index]]
                                          ['surname'],
                                  style: TextStyle(
                                      color: CustomColors.indigo,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),

                                const Expanded(child: SizedBox()),
                                Icon(
                                  Icons.arrow_forward,
                                  color: CustomColors.indigo,
                                ) //TODO: ICON
                              ],
                            ),
                          ),
                        ));
                  }),
                  itemCount: allUsers == null ? 0 : allUsers!.length,
                )
        ],
      ),
    );
  }
}
