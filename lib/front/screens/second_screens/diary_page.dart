import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late Map schedule = {};
  final List _keys = [];
  @override
  void initState() {
    get_schedule(Utils.userId!).then(
      (value) {
        setState(() {
          schedule = value;
          _keys.addAll(schedule.keys);
          _keys.sort(((a, b) => int.parse(b).compareTo(int.parse(a))));
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 40, top: 40, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: CustomColors.indigo,
                      ))), //TODO: icon
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 47,
                  child: Center(
                    child: Text('Дневник',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.indigo)),
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _keys.isNotEmpty
            ? Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 45,
                    child: Text(
                      'Дата',
                      style: TextStyle(
                          color: CustomColors.hintTextField,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Оценки',
                    style: TextStyle(
                        color: CustomColors.hintTextField,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    'dance coins',
                    style: TextStyle(
                        color: CustomColors.hintTextField,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ],
              )
            : const Center(
                child: Text('Пока нет оценок'),
              ),
        const SizedBox(
          height: 20,
        ),
        _keys.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, ind) {
                      List temp = schedule[_keys[index]].keys.toList();
                      temp.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
                      return schedule[_keys[index]][temp[ind]]['child']
                                  [Utils.userId]['mark'] !=
                              -1
                          ? buildMark(schedule[_keys[index]][temp[ind]])
                          : const SizedBox();
                    },
                    itemCount: schedule[_keys[index]].keys.length,
                  );
                },
                itemCount: _keys.length,
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
      ]),
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
      ), //TODO: Поменять иконки
    );
  }

  Widget buildMark(Map lesson) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 45,
          child: Text(
            DateFormat('d.M\nHH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(lesson['from'] * 1000)),
            style: TextStyle(
                color: CustomColors.indigo,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 50,
          width: 2,
          color: CustomColors.gray,
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: CustomColors.orange,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Text(
            lesson['child'][Utils.userId]['mark'] == 1
                ? "Н"
                : lesson['child'][Utils.userId]['mark'].toString(),
            style: TextStyle(
                color: CustomColors.white,
                fontWeight: FontWeight.normal,
                fontSize: 24),
          )),
        ),
        const SizedBox(
          width: 42,
        ),
        SizedBox(
          height: 45,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lesson['child'][Utils.userId]['mark'] == 5
                  ? 2
                  : lesson['child'][Utils.userId]['mark'] == 4
                      ? 1
                      : 0,
              itemBuilder: (context, ind) {
                return Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(Utils.coin))),
                );
              }),
        ),
      ],
    );
  }
}
