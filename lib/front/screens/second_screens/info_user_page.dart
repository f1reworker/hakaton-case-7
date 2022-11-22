import 'package:flutter/material.dart';
import 'package:hakaton_case_7/front/theme/colors.dart';

class InfoUserPage extends StatefulWidget {
  final Map user;
  final String userId;
  const InfoUserPage({Key? key, required this.user, required this.userId})
      : super(key: key);

  @override
  State<InfoUserPage> createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F4F6),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [BackButton(), Expanded(child: SizedBox())],
                ),
              ),
              widget.user['ava'] == null
                  ? Container(
                      width: 82,
                      height: 82.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.wgrey))
                  : Container(
                      width: 82,
                      height: 82.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.user['ava'])))),
              const SizedBox(
                height: 11,
              ),
              Text(
                widget.user['name'] + ' ' + widget.user['surname'],
                style: TextStyle(
                    color: CustomColors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 224,
                    maxHeight: double.infinity),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfo('Имя',
                          widget.user['name'] + ' ' + widget.user['surname']),
                      widget.user['status'] != null
                          ? buildInfo('Статус', widget.user['status'])
                          : const SizedBox(),
                      widget.user['lesson'] != null
                          ? buildInfo('Направление', widget.user['lesson'])
                          : const SizedBox(),
                      buildInfo('Почта', widget.user['email']),
                      widget.user['school'] != null
                          ? buildInfo('Школа', widget.user['school'])
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildInfo(String name, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 28,
        ),
        Text(
          name,
          style: TextStyle(
              color: CustomColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            info,
            style: TextStyle(
                color: CustomColors.indigo,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
