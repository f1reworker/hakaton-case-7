import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/page_provider.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/auth_pages/start_screen.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('userId');
  if (userId != null) {
    Utils.userId = userId;
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PageProvider>(create: (_) => PageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int page = context.watch<PageProvider>().getPage;
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.transparent,
            fontFamily: 'Poppins',
            backgroundColor: CustomColors.background),
        title: 'Flutter Demo',
        //theme: CustomTheme.lightTheme,
        home: Utils.userId != null
            ? MainPage(
                index: page,
              )
            : const FirstScreen());
  }
}
