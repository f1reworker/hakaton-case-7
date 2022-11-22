import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_teacher_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SchedulePageTeacher extends StatefulWidget {
  const SchedulePageTeacher({Key? key}) : super(key: key);

  @override
  State<SchedulePageTeacher> createState() => _SchedulePageTeacherState();
}

class _SchedulePageTeacherState extends State<SchedulePageTeacher> {
  late List keys = [];
  late Map schedule = {};
  int _selectDate = (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 3)
              .toUtc()
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
    get_teacher_schedule(
      Utils.userId!,
      Utils.userId!,
    ).then((value) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          SizedBox(
            height: 47,
            child: Center(
              child: Text('Расписание',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.indigo)),
            ),
          ),
          schedule.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    height: 65,
                    child: ListView.separated(
                      controller: ScrollController(
                          initialScrollOffset:
                              ((MediaQuery.of(context).size.width - 80) / 7) *
                                      keys.indexOf(_selectDate.toString()) -
                                  (MediaQuery.of(context).size.width - 80) / 7),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: _selectDate.toString() == keys[index]
                                ? CustomColors.indigo
                                : Colors.transparent),
                        width: (MediaQuery.of(context).size.width - 80) / 7,
                        height: 59,
                        child: TextButton(
                          onPressed: () => _changeDay(int.parse(keys[index])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getWeekDay(int.parse(keys[index])),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color:
                                          _selectDate.toString() == keys[index]
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
                                      color:
                                          _selectDate.toString() == keys[index]
                                              ? CustomColors.white
                                              : CustomColors.indigo)),
                            ],
                          ),
                        ),
                      ),
                      itemCount: keys.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(),
                    ),
                  ),
                )
              : const Center(child: Text('Вашего расписания пока нет')),
          keys.isNotEmpty
              ? Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Text("Время",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.gray)),
                    const SizedBox(
                      width: 30,
                    ),
                    Text('Тренировки',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.gray))
                  ],
                )
              : const SizedBox(),
          schedule[_selectDate.toString()] != null
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    List temp = schedule[_selectDate.toString()].keys.toList();
                    temp.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
                    return BuildLesson(
                        lesson: schedule[_selectDate.toString()][temp[index]],
                        first: index == 0);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(),
                  itemCount: schedule[_selectDate.toString()] == null
                      ? 0
                      : schedule[_selectDate.toString()].length)
              : const Text('Занятий нет')
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildLesson extends StatefulWidget {
  Map? lesson;
  bool first;
  BuildLesson({Key? key, required this.lesson, required this.first})
      : super(key: key);

  @override
  State<BuildLesson> createState() => _BuildLessonState();
}

class _BuildLessonState extends State<BuildLesson> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: widget.lesson == null
          ? const SizedBox()
          : Row(
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
                            DateFormat('HH:mm')
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    widget.lesson!['from'] * 1000))
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.indigo)),
                        Text(
                            DateFormat('HH:mm')
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
                    height: 147,
                    width: 1,
                    color: CustomColors.gray,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: widget.first
                              ? CustomColors.indigo
                              : CustomColors.wgrey),
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 137,
                      width: MediaQuery.of(context).size.width - 128,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: widget.first
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.lesson!['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.white)),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(widget.lesson!['theme'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: CustomColors.white)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place_outlined, //TODO: иконка
                                        color: CustomColors.white,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(widget.lesson!['place'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.white)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: CustomColors.white,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                          'Группа №${widget.lesson!['group']}', //TODO: иконка
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.white))
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.lesson!['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.indigo)),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(widget.lesson!['theme'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: CustomColors.indigo)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place_outlined,
                                        color: CustomColors.gray,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(widget.lesson!['place'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.indigo)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: CustomColors.white,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                          'Группа №${widget.lesson!['group']}', //TODO: иконка
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.indigo))
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                  )
                ]),
    );
  }
}
