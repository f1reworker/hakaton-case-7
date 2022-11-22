import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakaton_case_7/back/auth.dart';
import 'package:hakaton_case_7/back/get_type.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future loginUser() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final result = await login(
          _emailController.text.replaceAll(' ', ''), _passwordController.text);
      if (result == 0) {
        Fluttertoast.showToast(
            msg: "Неверный email или пароль!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      } else if (result == -1) {
        Fluttertoast.showToast(
            msg: "Что-то пошло не так, попробуйте позже",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      } else {
        return result;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 24,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              primary: false,
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 510,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: CustomColors.indigo),
                      )),
                  const SizedBox(
                    height: 38,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.hintTextField),
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 54 - 30,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "поле  не заполнено";
                            } else if (!EmailValidator.validate(
                                value!.replaceAll(' ', ''))) {
                              return "почта некорректна";
                            }
                            return null;
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: null,
                            border: InputBorder.none,
                          ),
                          controller: _emailController,
                        ),
                      ),
                      const Icon(Icons.done)
                    ],
                  ),
                  Divider(
                    color: CustomColors.indigo,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Пароль',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.hintTextField),
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 54 - 30,
                        child: TextFormField(
                          validator: (value) => value!.length < 6
                              ? "пароль меньше 6 символов"
                              : null,
                          obscureText: !_showPassword ? true : false,
                          decoration: const InputDecoration.collapsed(
                            hintText: null,
                            border: InputBorder.none,
                          ),
                          controller: _passwordController,
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: _togglevisibility,
                          icon: _showPassword
                              ? const Icon(Icons.visibility_rounded)
                              : const Icon(Icons.visibility_off_rounded))
                    ],
                  ),
                  Divider(
                    color: CustomColors.indigo,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.indigo),
                      ),
                    ),
                  ), //TODO: добавить функцию
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                      height: 72,
                      width: MediaQuery.of(context).size.width - 54,
                      decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: CustomColors.indigo),
                        color: CustomColors.indigo,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(28)),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await loginUser().then((value) async {
                            if (value != null) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('userId', value);
                              Utils.userId = value;
                              String type = await get_type();
                              Utils.type = type;
                              await prefs.setString('type', type);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const MainPage(index: 0),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ));
                            }
                          });
                        },
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
                    height: 109,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
