import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('chats${Utils.userId!}')
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                _chats.add(element.id);
              });
            }));
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
                  child: Icon(
                    Icons.search,
                    color: CustomColors.white,
                  ),
                ), //TODO: иконка
                Text('Чаты',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.indigo)),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(Utils.userId!)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.data() != null) {
                        final Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Container(
                            width: 44,
                            height: 44.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data['ava']))));
                      } else {
                        return Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(22)),
                              color: CustomColors.gray),
                        );
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.builder(
                itemCount: 15,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.all(3),
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(29)),
                          color: CustomColors.gray),
                    )),
          ),
          const SizedBox(height: 28),
          Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 268,
                maxHeight: double.infinity),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: CustomColors.wgrey),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(22)),
                              color: CustomColors.indigo),
                          child: Icon(
                            Icons.search,
                            color: CustomColors.white,
                          ),
                        ), //TODO: иконка
                        Text('Контакты',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.indigo)),
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(22)),
                              color: CustomColors.indigo),
                          child: Icon(
                            Icons.person_add_alt,
                            color: CustomColors.white,
                          ), //TODO: иконка
                        ),
                      ]),
                ),
                const SizedBox(height: 5),
                _chats.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _chats.length,
                        itemBuilder: (BuildContext context, index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(_chats[index])
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.data() != null) {
                                  final Map<String, dynamic> data =
                                      snapshot.data!.data()
                                          as Map<String, dynamic>;
                                  return TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            const EdgeInsets.all(0))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                DialogPage(
                                              withUser: _chats[index],
                                            ),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, left: 27, right: 22),
                                        child: SizedBox(
                                            height: 52,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                54,
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
                                                                data['ava'])))),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                        '${data["name"]} ${data["surname"]}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: CustomColors
                                                                .indigo)),
                                                    StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'chats${Utils.userId}')
                                                            .doc(_chats[index])
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    DocumentSnapshot>
                                                                snap) {
                                                          if (snap.hasData &&
                                                              snap.data!
                                                                      .data() !=
                                                                  null) {
                                                            final Map<String,
                                                                    dynamic>
                                                                dataMes = snap
                                                                        .data!
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;
                                                            if (dataMes
                                                                .isNotEmpty) {
                                                              return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    145,
                                                                child: Text(
                                                                    dataMes[(dataMes.length - 1).toString()][
                                                                                'text'] ==
                                                                            ""
                                                                        ? 'Вложение'
                                                                        : dataMes[(dataMes.length - 1)
                                                                                .toString()]
                                                                            [
                                                                            'text'],
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: CustomColors
                                                                            .gray)),
                                                              );
                                                            }
                                                          } else {
                                                            const SizedBox(
                                                              height: 12,
                                                            );
                                                          }
                                                          return const SizedBox(
                                                            height: 12,
                                                          );
                                                        }),
                                                  ],
                                                ),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'chats${Utils.userId}')
                                                        .doc(_chats[index])
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot>
                                                            snap) {
                                                      if (snap.hasData &&
                                                          snap.data!.data() !=
                                                              null) {
                                                        final Map<String,
                                                                dynamic>
                                                            dataMes =
                                                            snap.data!.data()
                                                                as Map<String,
                                                                    dynamic>;
                                                        if (dataMes
                                                            .isNotEmpty) {
                                                          int unread = 0;
                                                          for (int i = 0;
                                                              i <
                                                                  dataMes
                                                                      .length;
                                                              i++) {
                                                            if (dataMes[i.toString()]
                                                                        [
                                                                        'view'] ==
                                                                    false &&
                                                                !dataMes[i
                                                                        .toString()]
                                                                    [
                                                                    'from_me']) {
                                                              unread++;
                                                            }
                                                          }
                                                          if (unread != 0) {
                                                            return Container(
                                                              height: 22,
                                                              width: 22,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: CustomColors
                                                                      .orange),
                                                              child: Center(
                                                                child: Text(
                                                                    unread
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: CustomColors
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
                                } else {
                                  return const SizedBox();
                                }
                              });
                        })
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
