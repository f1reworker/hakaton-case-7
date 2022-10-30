import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/screens/first_screens/chats_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/content_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/home_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/schedule_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ChatsPage(),
    const SchedulePage(),
    const ContentPage(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
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
            selectedIconTheme: IconThemeData(color: CustomColors.orange),
            unselectedIconTheme: IconThemeData(color: CustomColors.white),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
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

      body: _widgetOptions.elementAt(selectedIndex),
    );
  }
}
