import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/screens/second_screens/settings_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class SettingsButton extends StatelessWidget {
  final Map user;
  const SettingsButton({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 38, top: 38),
        child: SizedBox(
          height: 18,
          width: 18,
          child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          SettingsPage(user: user),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
              },
              child: Icon(
                Icons.settings, //TODO: icom
                size: 18,
                shadows: [
                  BoxShadow(
                      blurStyle: BlurStyle.solid,
                      spreadRadius: 4,
                      color: CustomColors.indigo,
                      blurRadius: 6)
                ],
                color: CustomColors.white,
              )),
        ));
  }
}
