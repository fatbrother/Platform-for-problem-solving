import 'dart:ui';

import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        title: const BackButton(color: Colors.black),
        //bottomOpacity: 100, 
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
      body: const HomePage(),
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
        //BackButton(),
        Container(
          height: 44,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
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
                Text('帳號管理', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
                Icon(FeatherIcons.chevronsRight),
              ],
            ),
          ),
          /*
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(     // <-- TextButton
            onPressed: () {},
            icon: Icon(FeatherIcons.chevronsRight),
            label: Text('帳號管理', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
            style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: Alignment.centerRight, 
            )
          ),*/
        ),
        Container(
          height: 44,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
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
                Text('個人身分驗證', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
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
                foregroundColor: Colors.black,
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
                Text('意見回饋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
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
                foregroundColor: Colors.black,
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
                Text('聯絡客服', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
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
                foregroundColor: Colors.black,
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
                Text('服務條款', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
                Icon(FeatherIcons.chevronsRight),
              ],
            ),
          ),
        ),
        Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)
            )
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          //color: Colors.white,
          child: const Text('版本\n1.0.0' ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
        )
      ],
      /*children: <Widget>[
         Container(
          child: Text('帳號管理', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(20.0),
              topRight: const  Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0)
            )
          ),
          margin: EdgeInsets.all(10),
        ),
        Container(
          child: Text('個人身分驗證', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          decoration: new BoxDecoration(
            color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(20.0),
              topRight: const  Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0)
              )
          ),
          margin: EdgeInsets.all(10),
        ),
        Container(
          child: Text('意見回饋', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          decoration: new BoxDecoration(
            color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(20.0),
              topRight: const  Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0))
          ),
          margin: EdgeInsets.all(10),
        ),
        Container(
          child: Text('聯絡客服', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          decoration: new BoxDecoration(
            color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(20.0),
              topRight: const  Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0))
          ),
          margin: EdgeInsets.all(10),
        ),
        Container(
          child: Text('服務條款', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          decoration: new BoxDecoration(
            color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(20.0),
              topRight: const  Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0))
          ),
          margin: EdgeInsets.all(10),
        ),
        Container(
          color: Colors.white,
          child: Text('版本', style: TextStyle(fontSize: 20)),
          margin: EdgeInsets.all(10),
        )
      ],*/
    );

  }
}