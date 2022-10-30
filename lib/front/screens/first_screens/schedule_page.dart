import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late List keys = [];
  late Map schedule = {};
  String _selectDate = DateFormat('dd:MM').format(DateTime.now());

  String getWeekDay(String day) {
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
        DateTime.parse("2022-${day.split(':')[1]}-${day.split(':')[0]}")
                .weekday -
            1];
  }

  void _changeDay(String day) {
    setState(() {
      _selectDate = day;
    });
  }

  @override
  void initState() {
    get_schedule(Utils.userId!).then((value) {
      setState(() {
        keys = value.keys.toList();
        keys.sort((a, b) =>
            int.parse(a.split(":")[0]).compareTo(int.parse(b.split(":")[0])));
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
          keys.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: _selectDate == keys[index]
                                ? CustomColors.indigo
                                : Colors.transparent),
                        width: 40,
                        height: 57,
                        child: TextButton(
                          onPressed: () => _changeDay(keys[index]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getWeekDay(keys[index]),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: _selectDate == keys[index]
                                          ? CustomColors.white
                                          : CustomColors.gray)),
                              Text(keys[index].split(':')[0],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _selectDate == keys[index]
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
          keys.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      buildLesson(schedule[_selectDate][index], index == 0),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(),
                  itemCount: schedule[_selectDate] == null
                      ? 0
                      : schedule[_selectDate].length)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget buildLesson(Map lesson, bool first) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    DateFormat('HH:MM')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            lesson['from'] * 1000))
                        .toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.indigo)),
                Text(
                    DateFormat('HH:MM')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            lesson['to'] * 1000))
                        .toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.gray))
              ],
            ),
            const SizedBox(
              width: 16,
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
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: first ? CustomColors.indigo : CustomColors.wgrey),
                margin: const EdgeInsets.only(bottom: 10),
                height: 137,
                width: MediaQuery.of(context).size.width - 128,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: first
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lesson['name'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.white)),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(lesson['theme'],
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
                                Text(lesson['place'],
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
                                  Icons.circle, //TODO: фото
                                  color: CustomColors.white,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(lesson['teacher'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.white)),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lesson['name'],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.indigo)),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(lesson['theme'],
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
                                Text(lesson['place'],
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
                                  Icons.circle, //TODO: фото
                                  color: CustomColors.gray,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(lesson['teacher'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.indigo)),
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
