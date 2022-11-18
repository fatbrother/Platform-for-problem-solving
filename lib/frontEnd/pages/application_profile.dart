import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pops/rate.dart';
import 'package:pops/tags.dart';



class ApplicationProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 10),
      body: Column(
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
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(79, 128, 155, 100),
            ),
            height: 670,
            child:
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text('name'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 40,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.error_outline_rounded),
                              Text('2'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.star_border_rounded),
                              Text('3.5'),
                            ],
                          ),
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RatePage()));
                              },
                              icon: Icon(Icons.navigate_next_rounded)
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        minHeight: 40,
                      ),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('自我介紹kfokosekfoksorkofskorkofksofekrofksopkrofksokrofskrofkoskrokfoskfokrokefspkrfoskrs'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        minHeight: 40,
                      ),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('部分答案kakofakeokfoawkfokoekfokaeofkaowekfoakowekfowkeofkaowekfokawoekfoawkfokaoekfowkefoakwefkoawkeof'),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money_rounded),
                          Text('price')
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
                onPressed: (){
                  ChooseAlertDialog(context, '選擇後，將收取代幣。');
                },
                child: Text('確認選擇', style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(79, 128, 155, 100),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
            ),
          ),
        ],
      )
    );
  }
}

ChooseAlertDialog(BuildContext context, String message){
  AlertDialog dialog = AlertDialog(
    title: const Text('選擇這位解題者', style: TextStyle(color: Colors.black, fontSize: 12),),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(message, textAlign: TextAlign.center, ),
    actions: <Widget> [
      SizedBox(
        width: 600,
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(79, 128, 155, 180),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        )
                    )
                ),
                child: const Text("確認付款",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: (){
                  Navigator.of(context).pop();
                  PayAlertDialog(context, '付款成功！');
                },
              ),
            ),
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(0, 0, 0, 200),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        )
                    )
                ),
                child: const Text("取消",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      )
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}


PayAlertDialog(BuildContext context, String message){
  AlertDialog dialog = AlertDialog(
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(message, textAlign: TextAlign.center, ),
    actions: <Widget> [
      SizedBox(
        width: 600,
        height: 40,
        child:SizedBox(
          width: 600,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(79, 128, 155, 180),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    )
                )
            ),
            child: const Text("確認",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      )
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}

