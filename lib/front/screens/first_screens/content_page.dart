import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
import 'dart:math' as math;

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 35, right: 35, top: 40, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 24,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 47,
                  child: Center(
                    child: Text('Контент',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.indigo)),
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.person_sharp)) //TODO: icon
            ],
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 23,
                  crossAxisSpacing: 23,
                  crossAxisCount: 2,
                  children: <Widget>[
                    buildButton(
                        () {}, 'Добавить видео', context), //TODO: function
                    buildButton(
                        () {}, 'Смотреть других', context), //TODO: иконки
                    buildButton(() {}, 'Dance coins', context),
                    buildButton(() {}, 'Магазин', context),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width - 200,
                  height: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: CustomColors.indigo,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Записаться на конкурсы и соревнования',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.white)),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Transform.rotate(
                                angle: -135 * math.pi / 180,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: CustomColors.white,
                                  size: 40,
                                )))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildButton(
      void Function() onPressed, String text, BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 93) / 2,
      height: (MediaQuery.of(context).size.width - 93) / 2,
      decoration: BoxDecoration(
          color: CustomColors.indigo,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.white)),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
                alignment: Alignment.bottomRight,
                child: Transform.rotate(
                    angle: -135 * math.pi / 180,
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColors.white,
                      size: 40,
                    )))
          ],
        ),
      ),
    );
  }
}
