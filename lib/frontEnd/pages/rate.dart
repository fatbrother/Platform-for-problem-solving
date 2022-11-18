//import 'dart:html';

import 'package:flutter/material.dart';

class RatePage extends StatefulWidget{
  const RatePage({super.key});
  @override
  State<RatePage> createState() => _RatePageState();

}

class _RatePageState extends State<RatePage>{
int star_num = 6;
var RateBox = <Container>[
  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('name', style: TextStyle(fontSize: 20, color: Colors.black),),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
          ],
        ),
        Text('評語', style: TextStyle(fontSize: 15, color: Colors.black),)
      ],
    ),
  ),
  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('name', style: TextStyle(fontSize: 20, color: Colors.black),),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
          ],
        ),
        Text('評語', style: TextStyle(fontSize: 15, color: Colors.black),)
      ],
    ),
  ),
  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('name', style: TextStyle(fontSize: 20, color: Colors.black),),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
          ],
        ),
        Text('評語', style: TextStyle(fontSize: 15, color: Colors.black),)
      ],
    ),
  ),
  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('name', style: TextStyle(fontSize: 20, color: Colors.black),),
            Icon(Icons.star),
            Icon(Icons.star),
          ],
        ),
        Text('評語', style: TextStyle(fontSize: 15, color: Colors.black),)
      ],
    ),
  ),
  Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('name', style: TextStyle(fontSize: 20, color: Colors.black),),
            Icon(Icons.star),
          ],
        ),
        Text('評語', style: TextStyle(fontSize: 15, color: Colors.black),)
      ],
    ),
  ),
  Container()
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 10),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 35, left: 25, right: 25, bottom: 5),
                onPressed:(){Navigator.pop(context);},
                icon: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                  size: 30,
                )
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 20),
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(79, 128, 155, 100),
              ),
              height: 670,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 6? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 6;
                            });
                          },
                          child: const Text('全部', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 5? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 5;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('5', style: TextStyle(color: Colors.black, fontSize: 15)),
                              Icon(Icons.star_border_rounded, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 4? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 4;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('4', style: TextStyle(color: Colors.black, fontSize: 15)),
                              Icon(Icons.star_border_rounded, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 3? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 3;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('3', style: TextStyle(color: Colors.black, fontSize: 15)),
                              Icon(Icons.star_border_rounded, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 2? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 2;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('2', style: TextStyle(color: Colors.black, fontSize: 15)),
                              Icon(Icons.star_border_rounded, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: star_num == 1? const Color.fromRGBO(147, 188, 227, 0.5490196078431373): Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: (){
                            setState(() {
                              star_num = 1;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('1', style: TextStyle(color: Colors.black, fontSize: 15)),
                              Icon(Icons.star_border_rounded, color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        star_num == 5 || star_num == 6? RateBox[0]: RateBox[5],
                        star_num == 4 || star_num == 6? RateBox[1]: RateBox[5],
                        star_num == 3 || star_num == 6? RateBox[2]: RateBox[5],
                        star_num == 2 || star_num == 6? RateBox[3]: RateBox[5],
                        star_num == 1 || star_num == 6? RateBox[4]: RateBox[5],
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
