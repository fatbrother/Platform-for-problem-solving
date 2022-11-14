import 'package:flutter/material.dart';
import 'package:pops/frontEnd/pages/change_phone_number_page.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '個人身分驗證';
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

        body: const IdentificationView(),
      ),
    );
  }
}

class IdentificationView extends StatelessWidget {
  const IdentificationView({super.key});
  final String _phoneNumber = "0911-111-111";
  final String _personalState = "未啟用";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          PhoneNumberWidget(phoneNumber: _phoneNumber,),
          const SizedBox(height: 19),
          PersonalStateWidget(personalState: _personalState,),
          const SizedBox(height: 19),
          const ChangePhoneNumberWiget(),
          const SizedBox(height: 19),
          const Vertification(),
        ],
      ),
    );
  }
}


//列出手機號碼
class PhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;
  const PhoneNumberWidget({super.key, required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Container(
          //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:const Color.fromARGB(255, 255, 255, 255),
          ),
          alignment: Alignment.center,
          child: Text(
            "手機號碼\n$phoneNumber",
            textAlign: TextAlign.center,
            style: const TextStyle(//letterSpacing: 10,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0)),
        )
      ),
    );
  }
}


//啟用與否
class PersonalStateWidget extends StatelessWidget {
  final String personalState;
  const PersonalStateWidget({super.key, required this.personalState});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
          //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:const Color.fromARGB(255, 255, 255, 255),
          ),
          alignment: Alignment.center,
          child: Text(
            personalState,
            textAlign: TextAlign.center,
            style: const TextStyle(//letterSpacing: 10,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      );
    }
  }

//修改手機號碼按鈕
class ChangePhoneNumberWiget extends StatelessWidget {
  const ChangePhoneNumberWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: InkWell(
            onTap:(){
              //-->修改手機號碼changePhoneNumber
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePhoneNumberPage()));
            },
          child: Stack (
            children: <Widget>[
              Container(
              //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:const Color.fromARGB(255, 255, 255, 255),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '修改手機號碼',
                  textAlign: TextAlign.center,
                  style: TextStyle(//letterSpacing: 10,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
                ),
            ),

            Container(
              alignment: const Alignment(1, 0),
              child: const Icon(
                Icons.double_arrow,
                color: Color.fromARGB(177, 59, 59, 59),
                ),
            )
          ]
        ),
      ),
    );
  }
}

//傳送驗證碼按鈕
class Vertification extends StatelessWidget {
  const Vertification({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: InkWell(
          onTap:(){
            showAlertDialog(context);
          },
        child: Container(
          //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:const Color.fromARGB(255, 255, 255, 255),
          ),
          alignment: Alignment.center,
          child: const Text(
            '傳送驗證碼',
            textAlign: TextAlign.center,
            style: TextStyle(//letterSpacing: 10,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0)),
          )
        ),
      ),
    );
  }
}
//show AlertDialog
showAlertDialog(BuildContext context){
  AlertDialog dialog = AlertDialog(
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: const Text("驗證碼已傳送", textAlign: TextAlign.center, ),
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
            ),
          ),
          child: const Text("確認",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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