import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/get_articles.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:hakaton_case_7/front/theme/my_todo_icons.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List keys = [];
  late Map articles;

  @override
  void initState() {
    getArticles().then((value) {
      setState(() {
        keys = value.keys.toList();
        articles = value;
      });
    });
    super.initState();
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
      ),
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
                      child: Text('Новости',
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
          SizedBox(
            height: 64,
            child: ListView.builder(
                itemCount: 15,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.all(3),
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(29)),
                          color: CustomColors.gray),
                    )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 232,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: keys.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Map art = articles[keys[index]];
                  String text = art['text'].toString().replaceAll('/n', '\n');
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Row(children: [
                          Container(
                              width: 55,
                              height: 55.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(art['ava'])))),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(1),
                            //width: MediaQuery.of(context).size.width - 60,
                            decoration: BoxDecoration(
                                color: CustomColors.indigo,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                            child: Text(art['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.white)),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          )
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(text,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: CustomColors.indigo)),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(art['attachments'])))),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
