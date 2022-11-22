import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/auth_pages/start_screen.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Map user;
  const SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
                      child: Text('Настройки',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              height: 60,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.user['ava']))),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user['name'] + ' ' + widget.user['surname'],
                        style: TextStyle(
                            color: CustomColors.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.user['status'],
                        style: TextStyle(
                            color: CustomColors.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    color: CustomColors.orange,
                  ) //TODO: ICON
                ],
              ),
            ),
          ),
          buildButton(
              'Аккаунт',
              'Приватность, изменить номер, добавить информацию о себе',
              Icon(
                Icons.vpn_key_rounded,
                color: CustomColors.hintTextField,
              ),
              null), //TODO: ICON
          buildButton(
              'Уведомления',
              'Сообщения, лайки, дэнскоины',
              Icon(
                Icons.notifications_none,
                color: CustomColors.hintTextField,
              ),
              null),
          buildButton(
              'Помощь',
              null,
              Icon(
                Icons.help_outline,
                color: CustomColors.hintTextField,
              ),
              null),
          buildButton(
              'Пригласить друга',
              null,
              Icon(
                Icons.people_alt_outlined,
                color: CustomColors.hintTextField,
              ),
              null),
          buildButton(
              'Выйти',
              null,
              Icon(
                Icons.exit_to_app_outlined,
                color: CustomColors.hintTextField,
              ), () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('userId');
            await prefs.remove('type');
            Utils.userId = null;
            Utils.type = null;
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const FirstScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
          }),
        ]),
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
      ), //TODO: Поменять иконки
    );
  }

  Widget buildButton(String name, String? about, Icon icon, onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: TextButton(
          style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.wgrey,
                  ),
                  child: icon),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: CustomColors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  about == null
                      ? const SizedBox()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            about,
                            style: TextStyle(
                                color: CustomColors.gray,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
              //const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
