import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/chats_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/content_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/child/home_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/child/schedule_page.dart';
import 'package:hakaton_case_7/front/screens/first_screens/teacher/home_page_teacher.dart';
import 'package:hakaton_case_7/front/screens/first_screens/teacher/schedule_page_teacher.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late int selectedIndex;
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    Utils.type == 'teacher'
        ? _widgetOptions = <Widget>[
            const HomePageTeacher(),
            const ChatsPage(),
            const SchedulePageTeacher(),
            const ContentPage(),
          ]
        : Utils.type == 'child'
            ? _widgetOptions = <Widget>[
                const HomePage(),
                const ChatsPage(),
                const SchedulePage(),
                const ContentPage(),
              ]
            : _widgetOptions = <Widget>[
                const HomePage(),
                const ChatsPage(),
                const SchedulePage(),
                const ContentPage(),
              ];
  }

  void onItemTapped(int index) {
    // FirebaseDatabase.instance.ref('schedule/0').set({
    //   "1668729600": {
    //     "1668768300": {
    //       "from": 1668768300,
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1668771900
    //     },
    //     "1668775500": {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "from": 1668775500,
    //       "name": "Хореография",
    //       "place": "Аудитория 1",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "хореографическая программа",
    //       "to": 1668782700
    //     }
    //   },
    //   "1668816000": {
    //     '1668851100': {
    //       "from": 1668851100,
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1668853800
    //     },
    //     '1668854400': {
    //       "from": 1668854400,
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1668861600
    //     }
    //   },
    //   "1668902400": {
    //     '1668948000': {
    //       "from": 1668948000,
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1668951600
    //     },
    //     '1668952200': {
    //       "from": 1668952200,
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1668955800
    //     }
    //   },
    //   "1668988800": {
    //     '1669042200': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "from": 1669042200,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669045800
    //     },
    //     '1669046400': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': 4,
    //           'coin': 1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': 5,
    //           'coin': 2,
    //         }
    //       },
    //       "from": 1669046400,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669050000
    //     }
    //   },
    //   "1669075200": {
    //     '1669107600': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': -1,
    //           'coin': -1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': -1,
    //           'coin': -1,
    //         }
    //       },
    //       "from": 1667037900,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669110300
    //     },
    //     '1669113900': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': -1,
    //           'coin': -1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': -1,
    //           'coin': -1,
    //         }
    //       },
    //       "from": 1669113900,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669121100
    //     }
    //   },
    //   "1669161600": {
    //     '1669207500': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': -1,
    //           'coin': -1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': -1,
    //           'coin': -1,
    //         }
    //       },
    //       "from": 1669207500,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669211100
    //     },
    //     '1669214700': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': -1,
    //           'coin': -1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': -1,
    //           'coin': -1,
    //         }
    //       },
    //       "from": 1669214700,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "2y40k8niE3MO0dh9g3xlzefkAJB2",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669218300
    //     }
    //   },
    //   "1669248000": {
    //     '1669304700': {
    //       "child": {
    //         'bTgweDqghXMcj1VuuiRuWQcnXgS2': {
    //           'mark': -1,
    //           'coin': -1,
    //         },
    //         '6AjtZYjXPPaX38qCWWgL7SwUMrD2': {
    //           'mark': -1,
    //           'coin': -1,
    //         }
    //       },
    //       "from": 1669304700,
    //       "name": "Джаз",
    //       "place": "Аудитория 2",
    //       "teacher": "c7qfb5OFvjPsGDb2flUtETtsIrj1",
    //       "theme": "постановка номера по джазу",
    //       "to": 1669311900
    //     }
    //   }
    // });
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
            onTap: onItemTapped,
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
