// ignore_for_file: unnecessary_new, constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        title: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
      body: HomePage(),
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget> [
        Container(
          height: 64,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(20.0),
          )
          ,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          //color: Colors.white,
          child: const Text('使用者帳號\nCatCat' ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
        ),
        Container(
          height: 64,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Opacity(
                  opacity: 0,
                  child: Icon(FeatherIcons.chevronsRight),
                ),
                Text('常用信箱\nCuteCat@gmail.com', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
                Icon(FeatherIcons.chevronsRight),
              ],
            ),
          ),
        ),
        Container(
          height: 44,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Opacity(
                  opacity: 0,
                  child: Icon(FeatherIcons.chevronsRight),
                ),
                Text('修改密碼', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
                Icon(FeatherIcons.chevronsRight),
              ],
            ),
          ),
        ),
        Container(
          height: 44,
          margin: const EdgeInsets.all(10),
          child: TextButton(     // <-- TextButton
            onPressed: () async {
              final ConfirmAction? action = await confirmDialog(context);
              //print("你選擇：$action");
            },
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: Alignment.center, 
            ),
            child: const Text('刪除帳號', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center)
          ),
          
        ),
      ],
    );

  }
}

enum ConfirmAction { ACCEPT, CANCEL }

Future<ConfirmAction?> confirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('您確定要刪除帳號嗎？'),
        actions: <Widget>[
          TextButton(
            child: const Text('確認'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          ),
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          )
        ],
      );
    },
  );
}