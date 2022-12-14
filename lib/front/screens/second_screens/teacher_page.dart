import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';
import 'package:intl/intl.dart';

class TeacherPage extends StatefulWidget {
  final String teacherId;
  final Map info;
  const TeacherPage({Key? key, required this.teacherId, required this.info})
      : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  late Map schedule = {};
  final String key = '${DateTime.now().day}:${DateTime.now().month}';
  @override
  void initState() {
    get_schedule(widget.teacherId).then((value) {
      setState(() {
        schedule = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                      child: Text(
                          "${widget.info['name']} ${widget.info['surname']}",
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
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                height: 142,
                width: 142,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.info['ava'])),
                    shape: BoxShape.circle),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  widget.info['info'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomColors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.indigo,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: 57,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '???????????????????? ???? ??????????????',
                      style: TextStyle(
                          color: CustomColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              schedule[key] == null
                  ? const Center(child: Text('?????????????? ?????? ??????????????'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schedule[key].length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildLesson(
                              context, index == 0, schedule[key][index]))
            ],
          ),
        ],
      ),
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
      ), //TODO: ???????????????? ????????????
    );
  }

  Widget buildLesson(BuildContext context, bool first, Map lesson) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 35, 13),
      child: SizedBox(
        height: 80,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              DateFormat('HH:MM')
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      lesson['from'] * 1000))
                  .toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: first ? CustomColors.orange : CustomColors.indigo,
              )),
          const SizedBox(
            width: 7,
          ),
          Container(
            width: 2,
            height: 80,
            color: first ? CustomColors.orange : CustomColors.indigo,
          ),
          const SizedBox(
            width: 17,
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 113,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: first ? CustomColors.orange : CustomColors.gray,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lesson['name'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: first
                                ? CustomColors.white
                                : CustomColors.indigo,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          "${((lesson['to'] - lesson['from']) / 60).ceil()} ?????? ??????????????",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: first
                                ? CustomColors.white
                                : CustomColors.indigo,
                          )),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 50,
                  color: first ? CustomColors.white : CustomColors.indigo,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
