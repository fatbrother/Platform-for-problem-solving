import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '修改密碼';
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
                onPressed: () => Navigator.of(context).pop(),
              );
            },
          ),
          //AppBar color and word
          backgroundColor: const Color.fromARGB(222, 255, 255, 255),
          title: const Text(appTitle,  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))), 
          centerTitle: true,
        ),

        body: ChangePasswordView(),
      ),
    );
  }
}


String judge(String currentOldPassword, String inputOldPassword, String againNewPassword, String firstNewPassword)
{
  String message = "";
  //若輸入的InputOldPassword和資料庫存放的資料不同時，message = "舊密碼輸入錯誤";
  //密碼是否符合規則的判斷
  if(currentOldPassword != inputOldPassword)
  {
    message = "舊密碼輸入錯誤"; 
  }
  else if(firstNewPassword == againNewPassword)
  {
    message = "密碼修改成功";
  }
  else
  {
    message = "兩次新密碼輸入不相同";
  }
  return message;
}



class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var message = "";
  var currentOldPassword = "";
  var inputOldPassword = "";
  var firstNewPassword = "";
  var againNewPassword = "";

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          //輸入舊密碼
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _textController,
                onChanged: (text){
                  setState(() {
                    inputOldPassword = _textController.text;
                    },
                  );
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '輸入舊密碼',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19),//空
          //輸入新密碼
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _textController2,
                onChanged: (text){
                  setState(() {
                    firstNewPassword = _textController2.text;
                    },
                  );
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '輸入新密碼',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19),//空
          //確認新密碼
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _textController3,
                onChanged: (text){
                  setState(() {
                    againNewPassword = _textController3.text;
                    },
                  );
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '確認新密碼',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19),//空
          //確認修改按鈕+更改密碼
          SizedBox(
            height: 35,
            child: InkWell(
                onTap:(){
                  message = judge(currentOldPassword, inputOldPassword, againNewPassword, firstNewPassword);
                  if(message == "密碼修改成功")currentOldPassword = againNewPassword;//修改密碼
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
                '確認修改',
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




//show AlertDialog
showAlertDialog(BuildContext context, String message){

  AlertDialog dialog = AlertDialog(
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(message, textAlign: TextAlign.center, ),
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