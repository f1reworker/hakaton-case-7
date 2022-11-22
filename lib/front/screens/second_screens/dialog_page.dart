import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hakaton_case_7/back/send_message.dart';
import 'package:hakaton_case_7/back/upload_picture.dart';
import 'package:hakaton_case_7/back/utils.dart';
import 'package:hakaton_case_7/back/pick_image.dart';
import 'package:hakaton_case_7/front/screens/second_screens/info_user_page.dart';
import 'package:hakaton_case_7/front/screens/second_screens/message_page.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

class DialogPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String withUser;
  final Map user;
  DialogPage({Key? key, required this.withUser, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: CustomColors.indigo,
                      )),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(0)),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              InfoUserPage(user: user, userId: withUser),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        )),
                    child: Row(children: [
                      Stack(children: [
                        user['ava'] == null
                            ? Container(
                                width: 44,
                                height: 44.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.wgrey))
                            : Container(
                                width: 44,
                                height: 44.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(user['ava'])))),
                        Padding(
                          padding: const EdgeInsets.only(left: 34, top: 32),
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                color: true //TODO: online
                                    ? CustomColors.orange
                                    // ignore: dead_code
                                    : Colors.grey),
                          ),
                        )
                      ]),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            user['name'] + ' ' + user['surname'],
                            style: TextStyle(
                                color: CustomColors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            // ignore: dead_code
                            true ? "в сети" : "не в сети", //TODO: online
                            style: TextStyle(
                                color: CustomColors.gray,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
            MessagePage(withUser: withUser),
          ]),
        ),
        bottomSheet: Container(
          color: CustomColors.white,
          height: 70,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0))),
                onPressed: () async {
                  var images = await imagePicker();
                  // ignore: use_build_context_synchronously
                  if (images != null) checkImage(context, images);
                },
                child: Transform.rotate(
                    angle: -135 * math.pi / 180,
                    child: Icon(
                      Icons.attach_file,
                      size: 30,
                      color: CustomColors.indigo,
                    )), //TODO: Icon
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: CustomColors.indigo,
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: CustomColors.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      fillColor: CustomColors.indigo,
                      hintText: 'Написать сообщение'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (_controller.text != '') {
                      sendMessage(
                          withUser,
                          Utils.userId!,
                          null,
                          _controller.text,
                          (DateTime.now().millisecondsSinceEpoch / 1000)
                              .ceil());
                      _controller.text = "";
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Icon(
                    Icons.send,
                    size: 30,
                    color: CustomColors.indigo,
                  ))
            ],
          ),
        ));
  }

  Future checkImage(BuildContext context, XFile images) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.file(File(images.path)),
                      Row(children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            child: Icon(
                              Icons.close,
                              color: CustomColors.indigo,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            child: Icon(
                              Icons.send,
                              color: CustomColors.indigo,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              uploadFile(images.name, images.path, 'chats')
                                  .then((value) {
                                if (value != null) {
                                  sendMessage(
                                      withUser,
                                      Utils.userId!,
                                      value,
                                      '',
                                      (DateTime.now().millisecondsSinceEpoch /
                                              1000)
                                          .ceil());
                                }
                              });
                            },
                          ),
                        ),
                      ])
                    ],
                  )),
            ),
          ));
        });
  }
}
