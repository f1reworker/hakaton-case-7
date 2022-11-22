import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/models/settings_button.dart';
import 'package:hakaton_case_7/front/screens/second_screens/diary_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/list_teacher_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/news_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/raiting_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool newUser = true;
  Map? user;
  late Map schedule = {};
  final String key = (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 3)
              .millisecondsSinceEpoch /
          1000)
      .ceil()
      .toString();
  @override
  void initState() {
    get_schedule(Utils.userId!).then(
      (value) {
        setState(() {
          newUser = value.isEmpty;
          schedule = value;
        });
      },
    );
    FirebaseDatabase.instance.ref("users/${Utils.userId}").get().then((value) {
      user = value.value as Map;
      setState(() {});
    });
    super.initState();
  }

  // ignore: non_constant_identifier_names
  String get_sch(key, schedule) {
    List temp = schedule[key].keys.toList();
    temp.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    final result = DateFormat('HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(temp[0]) * 1000));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(children: [
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Stack(
                      children: [
                        Container(
                            width: 55,
                            height: 55.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(user!['ava'])))),
                        SettingsButton(user: user!),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(user!['name'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.indigo)),
                    const Expanded(child: SizedBox()),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('currency')
                            .doc(Utils.userId!)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.data() != null) {
                            final Map<String, dynamic> coin =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Text(
                              coin['how'].toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.indigo),
                            );
                          } else {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.indigo),
                            );
                          }
                        }),
                    const SizedBox(
                      width: 3,
                    ),
                    Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              DecorationImage(image: NetworkImage(Utils.coin))),
                    )
                  ],
                ),
                const SizedBox(height: 34),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    newUser || schedule[key] == null
                        ? 'Привет, ${user!["name"]}!\nУ вас сегодня нет занятий'
                        : 'Привет, ${user!["name"]}!\nУ вас сегодня занятие в ${get_sch(key, schedule)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 34),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text('Активный абонемент',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.indigo))),
                ),
                Container(
                  height: 177,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: CustomColors.orange,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text('Джаз', //TODO: Запросы с бд
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white)),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Осталось занятий', //TODO: Запросы с бд
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.white)),
                            Text('12', //TODO: Запросы с бд
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 90,
                          height: 44,
                          decoration: BoxDecoration(
                              color: CustomColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: TextButton(
                            onPressed: () {}, //TODO: function
                            child: Text('Продлить абонемент',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.indigo)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 23,
                    crossAxisSpacing: 23,
                    crossAxisCount: 2,
                    children: <Widget>[
                      buildButton(() {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const ListTeacherPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }, 'Учителя'),
                      buildButton(() {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const NewsPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }, 'Новости'),
                      buildButton(() {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const RaitingPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }, 'Рейтинг'),
                      buildButton(() {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const DiaryPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }, 'Дневник'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ]),
            )),
          );
  }

  Widget buildButton(void Function() onPressed, String text) {
    return Container(
      width: (MediaQuery.of(context).size.width - 93) / 2,
      height: (MediaQuery.of(context).size.width - 93) / 2,
      decoration: BoxDecoration(
          color: CustomColors.indigo,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.white)),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
                alignment: Alignment.bottomRight,
                child: Transform.rotate(
                    angle: -135 * math.pi / 180,
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColors.white,
                      size: 40,
                    )))
          ],
        ),
      ),
    );
  }
}
