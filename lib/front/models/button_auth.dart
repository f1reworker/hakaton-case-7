import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class AuthButton extends StatelessWidget {
  final Color mainColor;
  final String text;
  final Color colorText;
  final void Function() onPressed;
  const AuthButton(
      {Key? key,
      required this.mainColor,
      required this.text,
      required this.colorText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72,
        width: MediaQuery.of(context).size.width - 54,
        decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: CustomColors.indigo),
          color: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: colorText),
              ),
              const Expanded(child: SizedBox()),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: colorText,
              ),
              const SizedBox(
                width: 24,
              )
            ],
          ),
        ));
  }
}
