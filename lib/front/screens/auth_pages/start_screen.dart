import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/screens/auth_pages/sign_in_page.dart';
import 'package:hakaton_case_7/front/screens/auth_pages/sign_up_page_first.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: Image.asset('assets/logo.png')),
              const SizedBox(
                height: 100,
              ),
              Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width - 54,
                  decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid, color: CustomColors.indigo),
                    color: CustomColors.indigo,
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const SignInPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        )),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Войти',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.white),
                        ),
                        const Expanded(child: SizedBox()),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: CustomColors.white,
                        ),
                        const SizedBox(
                          width: 24,
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width - 54,
                  decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid, color: CustomColors.indigo),
                    color: CustomColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const SignUpPageFirst(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        )),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.indigo),
                        ),
                        const Expanded(child: SizedBox()),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: CustomColors.indigo,
                        ),
                        const SizedBox(
                          width: 24,
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
