import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/models/settings_button.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/teacher/diary_teacher.dart';
import 'package:hakaton_case_7/front/screens/second_screens/news_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'dart:math' as math;

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({Key? key}) : super(key: key);

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  bool newUser = true;
  Map? user;
  late Map schedule = {};
  final String key = '${DateTime.now().day}:${DateTime.now().month}';
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
                    'Привет, ${user!["name"]}!\nВаше рабочее расписание проведения тренировок',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 34),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text('Рабочий день',
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
                        child: Text('Расписание занятий', //TODO: Запросы с бд
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white)),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 15),
                        child: Text('на сегодня', //TODO: Запросы с бд
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.white)),
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
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const MainPage(index: 2),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            //TODO: function
                            child: Text('Открыть календарь',
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
                                  DiaryPageTeacher(
                                ava: user!['ava'],
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }, 'Дневник'),
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
