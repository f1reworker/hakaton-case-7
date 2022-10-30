import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/diary_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class RaitingPage extends StatelessWidget {
  const RaitingPage({Key? key}) : super(key: key);

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
        ), //TODO: Поменять иконки
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 40, top: 40, bottom: 0),
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
                        child: Text('Рейтинг',
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
              height: 20,
            ),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: CustomColors.orange),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('currency')
                      .doc(Utils.userId!)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data!.data() != null) {
                      final Map<String, dynamic> coin =
                          snapshot.data!.data() as Map<String, dynamic>;
                      int count = coin['how'];
                      int max = count < 100 ? 100 : 500;
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                                "Уровень ${count < 100 ? 'начинающий' : 'ПРО'}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.white)),
                            const SizedBox(
                              height: 4,
                            ),
                            Text("ты набрал $count/$max денскоинов",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.white)),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 22,
                              width: MediaQuery.of(context).size.width - 70,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: CustomColors.white),
                              child: Row(
                                children: [
                                  Container(
                                      height: 22,
                                      width: count /
                                          max *
                                          (MediaQuery.of(context).size.width -
                                              70),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: CustomColors.gray)),
                                  const Expanded(child: SizedBox())
                                ],
                              ),
                            ),
                          ],
                        ),
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
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const DiaryPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  )),
              child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: CustomColors.orange100),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Дневник",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white)),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Icon(Icons.arrow_forward,
                                color: CustomColors.white, size: 60)
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }
}
