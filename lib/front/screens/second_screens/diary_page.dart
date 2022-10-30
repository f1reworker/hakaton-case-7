import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_schedule.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late Map schedule = {};
  final List<String> _items = [
    'октябрь',
  ];
  final List _keys = [];
  @override
  void initState() {
    get_schedule(Utils.userId!).then(
      (value) {
        setState(() {
          schedule = value;
          _keys.addAll(schedule.keys);
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
        Container(
          height: 44,
          width: MediaQuery.of(context).size.width - 54,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: CustomColors.indigo),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: DropdownButton(
              value: _items[0],
              isExpanded: true,
              elevation: 2,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.keyboard_arrow_down_sharp),
              ),
              underline: const SizedBox(),
              items: _items.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ),
        ),
        _keys.isNotEmpty
            ? Row(
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  Text(
                    'Дата',
                    style: TextStyle(
                        color: CustomColors.hintTextField,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    width: 28,
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
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 34,
                  ),
                  Text(
                    '11.10',
                    style: TextStyle(
                        color: CustomColors.indigo,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      '5',
                      style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24),
                    )),
                  ),
                  const SizedBox(
                    width: 42,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(Utils.coin))),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(Utils.coin))),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        _keys.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 29,
                  ),
                  Text(
                    '16.10',
                    style: TextStyle(
                        color: CustomColors.indigo,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      '5',
                      style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24),
                    )),
                  ),
                  const SizedBox(
                    width: 42,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(Utils.coin))),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(Utils.coin))),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        _keys.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '25.10',
                    style: TextStyle(
                        color: CustomColors.indigo,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
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
                        color: CustomColors.orange100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      '4',
                      style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24),
                    )),
                  ),
                  const SizedBox(
                    width: 42,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(Utils.coin))),
                  ),
                ],
              )
            : const SizedBox()
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
}
