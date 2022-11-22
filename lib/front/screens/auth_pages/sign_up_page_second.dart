import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakaton_case_7/back/auth.dart';
import 'package:hakaton_case_7/back/pick_image.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/front/models/button_auth.dart';
import 'package:hakaton_case_7/front/screens/first_screens/main_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPageSecond extends StatefulWidget {
  final String name;
  final String surname;
  final String school;
  final int age;
  final bool isChild;
  const SignUpPageSecond({
    Key? key,
    required this.name,
    required this.surname,
    required this.school,
    required this.age,
    required this.isChild,
  }) : super(key: key);

  @override
  State<SignUpPageSecond> createState() => _SignUpPageSecondState();
}

class _SignUpPageSecondState extends State<SignUpPageSecond> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _parentController = TextEditingController();
  XFile? avatar;
  final _formKey = GlobalKey<FormState>();

  Future auth() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final result = await register(
          _emailController.text.replaceAll(' ', ''),
          _passwordController.text,
          widget.age,
          avatar,
          widget.school,
          widget.name,
          widget.surname,
          widget.isChild ? "Child" : "Parent",
          _parentController.text);
      if (result == 0) {
        Fluttertoast.showToast(
            msg: "Пользователь с таким email уже есть!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (result == 1) {
        Fluttertoast.showToast(
            msg: "Пароль слишком длинный!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (result == 2) {
        Fluttertoast.showToast(
            msg: "Почта некорректна",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (result == -1 || result == null) {
        Fluttertoast.showToast(
            msg: "Что-то пошло не так, попробуйте позже",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                primary: false,
                dragStartBehavior: DragStartBehavior.down,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.indigo),
                        )),
                    const SizedBox(
                      height: 38,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Фото',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.hintTextField),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            imagePicker().then((value) => setState(
                                (() => value != null ? avatar = value : null)));
                          },
                          child: Container(
                            height: 121,
                            width: 121,
                            decoration: avatar == null
                                ? BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: CustomColors.wgrey)
                                : BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(avatar!.path)))),
                            child: avatar == null
                                ? Icon(
                                    Icons.add,
                                    color: CustomColors.gray,
                                    size: 42,
                                  )
                                : const SizedBox(),
                          ),
                        )),
                    if (widget.isChild)
                      buildInputText(_parentController, 'email родителя')
                    else
                      buildInputText(_parentController, 'email ребенка'),
                    buildInputText(_emailController, 'Email'),
                    buildInputText(_passwordController, 'Пароль'),
                    const SizedBox(
                      height: 24,
                    ),
                    AuthButton(
                        mainColor: CustomColors.indigo,
                        text: 'Создать аккаунт',
                        colorText: CustomColors.white,
                        onPressed: () async {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            await auth().then((value) async {
                              if (value != null) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('userId', value);
                                await prefs.setString('type',
                                    widget.isChild ? 'Child' : 'Parent');
                                Utils.userId = value;
                                Utils.type =
                                    widget.isChild ? 'child' : 'parent';
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
                          }
                        }),
                    const SizedBox(
                      height: 109,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget buildInputText(TextEditingController controller, String hintText) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hintText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.hintTextField),
            )),
        TextFormField(
          validator: (value) {
            if (value != null && value.isEmpty) {
              return "поле  не заполнено";
            } else if (hintText == "Email") {
              if (!EmailValidator.validate(value!.replaceAll(' ', ''))) {
                return "почта некорректна";
              }
            } else if (hintText == "Пароль") {
              if (value!.length < 6) return "пароль меньше 6 символов";
            }
            return null;
          },
          decoration: const InputDecoration.collapsed(
            hintText: null,
            border: InputBorder.none,
          ),
          controller: controller,
        ),
        Divider(
          color: CustomColors.indigo,
          thickness: 1,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
