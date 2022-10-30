import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/teacher_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  final List _allUsers = [];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                _allUsers.add(element.id);
              });
            }));
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
                    child: Text('Учителя',
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
        ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _allUsers.length,
            itemBuilder: (BuildContext context, int index) => StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_allUsers[index])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data!.data() != null) {
                    final Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return data['type'] == 'Teacher'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              height: 60,
                              child: TextButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(0)),
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              TeacherPage(
                                        teacherId: _allUsers[index],
                                        info: data,
                                      ),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    )), //TODO: route
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(data['ava']))),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['name'] + ' ' + data['surname'],
                                          style: TextStyle(
                                              color: CustomColors.indigo,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['lesson'],
                                          style: TextStyle(
                                              color: CustomColors.gray,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: CustomColors.indigo,
                                    ) //TODO: ICON
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                }))
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
