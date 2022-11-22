import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_teacher_schedule.dart';
import 'package:hakaton_case_7/back/update_mark.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DiaryPageTeacher extends StatefulWidget {
  String? ava;
  DiaryPageTeacher({Key? key, required this.ava}) : super(key: key);

  @override
  State<DiaryPageTeacher> createState() => _DiaryPageTeacherState();
}

Map schedule = {};

class _DiaryPageTeacherState extends State<DiaryPageTeacher> {
  late List keys = [];

  int _selectDate = (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 3)
              .millisecondsSinceEpoch /
          1000)
      .ceil();

  String getWeekDay(int day) {
    List weekdays = [
      'Пн',
      'Вт',
      'Ср',
      'Чт',
      'Пт',
      'Сб',
      'Вс',
    ];
    return weekdays[
        DateTime.fromMillisecondsSinceEpoch(day * 1000).weekday - 1];
  }

  void _changeDay(int day) {
    setState(() {
      _selectDate = day;
    });
  }

  @override
  void initState() {
    get_teacher_schedule(Utils.userId!, Utils.userId!).then((value) {
      int daysInMonth(DateTime date) => DateTimeRange(
              start: DateTime(date.year, date.month, 1),
              end: DateTime(date.year, date.month + 1))
          .duration
          .inDays;
      setState(() {
        for (var i = 0; i < daysInMonth(DateTime.now()); i++) {
          keys.add(
              ((DateTime(DateTime.now().year, DateTime.now().month, i, 3, 0, 0))
                          .millisecondsSinceEpoch /
                      1000)
                  .ceil()
                  .toString());
        }
        schedule = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: CustomColors.indigo),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: CustomColors.indigo,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: IconThemeData(color: CustomColors.white),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              //currentIndex: selectedIndex,
              onTap: (int i) => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        MainPage(index: i),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  )),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      MyTodo.home,
                      size: 27,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.chat_bubble,
                      size: 29,
                    ),
                    label: "AllTodos"),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyTodo.calendar,
                      size: 27,
                    ),
                    label: "Notes"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.star_border_rounded,
                      size: 35,
                    ),
                    label: "Profile"),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const BackButton(),
                  const Expanded(child: SizedBox()),
                  Text('Дневник',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.indigo)),
                  const Expanded(child: SizedBox()),
                  widget.ava == null
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
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.ava!)))),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Column(
                children: [
                  schedule.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            height: 65,
                            child: ListView.separated(
                              controller: ScrollController(
                                  initialScrollOffset: ((MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80) /
                                              7) *
                                          keys.indexOf(_selectDate.toString()) -
                                      (MediaQuery.of(context).size.width - 80) /
                                          7),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: _selectDate.toString() == keys[index]
                                        ? CustomColors.indigo
                                        : Colors.transparent),
                                width:
                                    (MediaQuery.of(context).size.width - 80) /
                                        7,
                                height: 57,
                                child: TextButton(
                                  onPressed: () =>
                                      _changeDay(int.parse(keys[index])),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(getWeekDay(int.parse(keys[index])),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: _selectDate.toString() ==
                                                      keys[index]
                                                  ? CustomColors.white
                                                  : CustomColors.gray)),
                                      Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  int.parse(keys[index]) * 1000)
                                              .day
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _selectDate.toString() ==
                                                      keys[index]
                                                  ? CustomColors.white
                                                  : CustomColors.indigo)),
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: keys.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(),
                            ),
                          ),
                        )
                      : const Center(child: Text('Вашего расписания пока нет')),
                  schedule[_selectDate.toString()] == null
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              update_mark(schedule);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 20, top: 10, bottom: 10),
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: CustomColors.orange100,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Сохранить ',
                                    style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.done,
                                    color: CustomColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  schedule[_selectDate.toString()] != null
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            List temp =
                                schedule[_selectDate.toString()].keys.toList();
                            temp.sort(
                                (a, b) => int.parse(a).compareTo(int.parse(b)));
                            return BuildLesson(
                              lesson: schedule[_selectDate.toString()]
                                  [temp[index]],
                              path1: _selectDate.toString(),
                              path2: temp[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(),
                          itemCount: schedule[_selectDate.toString()] == null
                              ? 0
                              : schedule[_selectDate.toString()].length)
                      : const Text('Занятий нет')
                ],
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class BuildLesson extends StatefulWidget {
  Map? lesson;
  String path1;
  String path2;
  BuildLesson(
      {Key? key,
      required this.lesson,
      required this.path1,
      required this.path2})
      : super(key: key);

  @override
  State<BuildLesson> createState() => _BuildLessonState();
}

class _BuildLessonState extends State<BuildLesson> {
  final Map user = {};
  @override
  void initState() {
    if (widget.lesson != null) {
      FirebaseDatabase.instance.ref('users').get().then((us) {
        for (var userId in widget.lesson!['child'].keys.toList()) {
          user[userId] = (us.value as Map)[userId];
        }
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: widget.lesson == null
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${widget.lesson!['name']}, Группа №${widget.lesson!['group']}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.indigo)),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 43,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                DateFormat('HH:MM')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        widget.lesson!['from'] * 1000))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.indigo)),
                            Text(
                                DateFormat('HH:MM')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        widget.lesson!['to'] * 1000))
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.gray))
                          ],
                        ),
                      ),
                      Container(
                        height: user.length * 25 > 50 ? user.length * 25 : 50,
                        width: 1,
                        color: CustomColors.gray,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      user.keys.isNotEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width - 128,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Row(
                                  children: [
                                    Text(
                                        user[user.keys.toList()[index]]
                                                ['surname'] +
                                            ' ' +
                                            user[user.keys.toList()[index]]
                                                ['name'][0] +
                                            '.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: CustomColors.indigo)),
                                    const Expanded(child: SizedBox()),
                                    SizedBox(
                                      width: 160,
                                      height: 20,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, ind) {
                                          void _changeSelectedItem(i) {
                                            setState(() {
                                              schedule[widget.path1]
                                                      [widget.path2]['child'][
                                                  user.keys.toList()[
                                                      index]]['coin'] = i == 4
                                                  ? 2
                                                  : i == 3
                                                      ? 1
                                                      : 0;
                                              schedule[widget.path1]
                                                              [widget.path2]
                                                          ['child']
                                                      [
                                                      user.keys.toList()[index]]
                                                  ['mark'] = i + 1;
                                            });
                                          }

                                          return GestureDetector(
                                            onTap: () =>
                                                _changeSelectedItem(ind),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 12),
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: ind ==
                                                          schedule[widget.path1]
                                                                          [widget.path2]
                                                                      ['child'][user
                                                                          .keys
                                                                          .toList()[
                                                                      index]]
                                                                  ['mark'] -
                                                              1
                                                      ? CustomColors.orange100
                                                      : CustomColors.gray,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                  child: Text(ind == 0
                                                      ? 'Н'
                                                      : (ind + 1).toString())),
                                            ),
                                          );
                                        },
                                        itemCount: 5,
                                      ),
                                    )
                                  ],
                                ),
                                itemCount: user.length,
                              ))
                          : const Expanded(child: SizedBox())
                    ]),
              ],
            ),
    );
  }
}
