
import 'package:flutter/material.dart';
import 'package:pops/tags.dart';
import 'package:pops/application_profile.dart';


class SingleProblemView extends StatefulWidget {
  const SingleProblemView({super.key});
  @override
  State<StatefulWidget> createState() => _SingleProblemView();
}

class _SingleProblemView extends State<SingleProblemView> {
  // ignore: non_constant_identifier_names
  List<WidgetBuilder> ApplicationBoxList = [
    (context) => const ApplicationBox()
  ];
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
              height: 700,
              margin: const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 0),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.zero, bottomRight: Radius.zero),
                color: Color.fromRGBO(79, 128, 155, 100),
              ),
             child: MediaQuery.removePadding(
               removeTop: true,
               context: context,
               child: ListView(
                 children: ApplicationBoxList
                     .map((WidgetBuilder applicationBox) => applicationBox(context))
                     .toList(),
               ),
             ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
              height: 35,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.zero, topLeft: Radius.zero, bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed:() {
                        DeleteAlertDialog(context, '刪除後不會歸還上架金額！');
                      },
                      icon: const Icon(Icons.delete)
                  ),
                  IconButton(
                      onPressed:() {
                        AddMoneyAlertDialog(context, '加價15代幣以增加平台推廣');
                      },
                      icon: const Icon(Icons.monetization_on_outlined)
                  ),
                ],
              ),

            )
          ],
        )
      );
  }
}


class ApplicationBox extends StatelessWidget{
  const ApplicationBox({super.key});
  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicationProfile()));},
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              // height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(79, 128, 155, 100),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: const Text('name', textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.attach_money),
                      Text('price'),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.discount_outlined),
                      ShowTagsWidget(title: '123'),
                      ShowTagsWidget(title: '123'),
                      ShowTagsWidget(title: '123'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
    );
  }
}




// ignore: non_constant_identifier_names
DeleteAlertDialog(BuildContext context, String message){
  AlertDialog dialog = AlertDialog(
    title: const Text('問題下架', style: TextStyle(color: Colors.black, fontSize: 12),),
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
                        const Color.fromRGBO(224, 210, 209, 100)
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
                child: const Text("確認刪除",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pop(context);
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

// ignore: non_constant_identifier_names
AddMoneyAlertDialog(BuildContext context, String message){
  AlertDialog dialog = AlertDialog(
    title: const Text('增加推廣', style: TextStyle(color: Colors.black, fontSize: 12),),
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

