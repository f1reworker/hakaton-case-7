import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/models/button_auth.dart';
import 'package:hakaton_case_7/front/screens/auth_pages/sign_up_page_second.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class SignUpPageFirst extends StatefulWidget {
  const SignUpPageFirst({Key? key}) : super(key: key);

  @override
  State<SignUpPageFirst> createState() => _SignUpPageFirstState();
}

class _SignUpPageFirstState extends State<SignUpPageFirst> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isChild = true;
  final List<String> _items = ['Родитель', 'Ребенок'];
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
                    Container(
                      height: 44,
                      width: MediaQuery.of(context).size.width - 54,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: CustomColors.indigo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: DropdownButton(
                          value: _isChild == true ? "Ребенок" : "Родитель",
                          isExpanded: true,
                          elevation: 2,
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.keyboard_arrow_down_sharp),
                          ),
                          underline: const SizedBox(),
                          items: _items.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              value == "Ребенок"
                                  ? _isChild = true
                                  : _isChild = false;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buildInputText(_nameController, 'Имя'),
                    buildInputText(_surnameController, 'Фамилия'),
                    buildInputText(_ageController, 'Возраст'),
                    buildInputText(_schoolController, 'Танцевальная школа'),
                    const SizedBox(
                      height: 24,
                    ),
                    AuthButton(
                        mainColor: CustomColors.indigo,
                        text: 'Далее',
                        colorText: CustomColors.white,
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1,
                                          animation2) =>
                                      SignUpPageSecond(
                                          name: _nameController.text,
                                          surname: _surnameController.text,
                                          school: _schoolController.text,
                                          age: int.parse(_ageController.text),
                                          isChild: _isChild),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ));
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
            } else if (hintText == "Возраст") {
              if (int.tryParse(_ageController.text) == null) {
                return "возраст введен неправильно";
              }
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
