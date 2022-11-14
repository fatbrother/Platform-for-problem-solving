import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const appTitle = '儲值';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(198, 192, 220, 236),
        appBar: AppBar(
          //build arrow_back
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 0, 0, 0),
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              );
            },
          ),
          //AppBar color and word
          backgroundColor: const Color.fromARGB(222, 255, 255, 255),
          title: const Text(appTitle,  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))), 
          centerTitle: true,
        ),

        body: const TopUpView(),
      ),
    );
  }
}
class TopUpView extends StatefulWidget{
  const TopUpView({super.key});

  @override
  _TopUpView createState() => _TopUpView();
}
class _TopUpView extends State<TopUpView> {
  var money = 0;
  final TextEditingController _controller = TextEditingController();
  bool seeMiddle = true;
  bool seeDown = false;
  int tapping = 1;
  void _changed(int tapping)
  {
    setState(() {
      if(tapping == 1)
      {
        seeMiddle = true;
        seeDown = false; 
      }
      else if(tapping == 2)
      {
        seeMiddle = false;
        seeDown = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          //輸入儲值金額
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _controller,
                onChanged: (text){
                  setState(() {
                    money =  int.parse(_controller.text);//string converts to int
                  });
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '輸入儲值金額',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19),//空
          //選擇支付方式
          Column(
            crossAxisAlignment : CrossAxisAlignment.center,
            children: [
              SizedBox(//上部分
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SvgPicture.asset('assets/top_up/top.svg',),
                ),
              ),
              SizedBox(//中部份
                child: InkWell(
                  onTap: (){
                    _changed(1);
                  },
                  child: Stack (
                    children: <Widget> [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SvgPicture.asset('assets/top_up/middle.svg',),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                        child: Visibility(
                            visible: seeMiddle,
                            child: const Icon(
                            Icons.radio_button_checked,
                            color:Color.fromARGB(255, 77, 104, 134) ,
                            ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(//下部分
                child: InkWell(
                  onTap: (){
                    _changed(2);
                  },
                  child: Stack (
                    children: <Widget> [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SvgPicture.asset('assets/top_up/down.svg',),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                        child: Visibility(
                            visible: seeDown,
                            child: const Icon(
                            Icons.radio_button_checked,
                            color:Color.fromARGB(255, 77, 104, 134) ,
                            ),
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 19),//空
          //確認儲值按鈕
          SizedBox(
            height: 35,
            child: InkWell(
                onTap:(){
                  String message = judge(money);
                  showAlertDialog(context, message);
                },
              child: Container(
              //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: const Text(
                '確認儲值',
                textAlign: TextAlign.center,
                style: TextStyle(//letterSpacing: 10,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
              )
            ),
            ),
          ),
        ],
      ),
    );
  }
}

String judge(int money)
{
  String message;
  if(money < 0) {
    message = "金額有誤，儲值失敗";
  } 
  else {
    message = "代幣增加" "$money";
  }
  return message;
}


//show AlertDialog
showAlertDialog(BuildContext context, String message){
  AlertDialog dialog = AlertDialog(
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(message, textAlign: TextAlign.center,),
    actions: <Widget> [
      SizedBox(
        width: 600,
        height: 40,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(198, 192, 220, 236)
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20), 
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(0), 
                    topRight: Radius.circular(0), 
                    ),
                )
            )
          ),
          child: const Text("確認",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
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

