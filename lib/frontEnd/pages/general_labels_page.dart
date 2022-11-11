import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/Show_Tags.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '一般標籤';
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

        body: GeneralLabelsView(),
      ),
    );
  }
}

class GeneralLabelsView extends StatefulWidget{
  @override
  _GeneralLabelsView createState() => _GeneralLabelsView();
}

class _GeneralLabelsView extends State<GeneralLabelsView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: [
          ShowCurrentTagsWidget(),
          SizedBox(height: 19),
          ShowUsedTagsWidget(),
          SizedBox(height: 19),
          //AddNewLabelText:59~96
          SizedBox(
            height: 35,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 12, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    onChanged: (text){
                      addtags =  text;
                    },
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: '新增標籤',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment(1, 0),
                    child: 
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,),
                      onPressed:(){
                        setState(() {
                          adding_len += (addtags.length + 3);
                        });
                        if(adding_len < 5)
                        {
                          ShowCurrentTagsWidget();
                        }
                      },
                    ),
                  ) 
                )
              ],   
            ), 
          ),
          SizedBox(height: 19),
          InstructionsWiget(),
        ],
      ),
    );
  }
}


class ShowCurrentTagsWidget extends StatelessWidget {
    const ShowCurrentTagsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 255, 255, 255),//color沒放在decoration裡的話會overflow
      ),
      child: 
      Container(
        child:
        Column( children: [
          Text(
              '目前顯示的專業標籤',
              textAlign: TextAlign.center,
               style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 5,),
          Row(
            children:[
              ShowTagsWidget(),
              const Text('  '),//2個空格當間隔
              ShowTagsWidget(),
              const Text('  '),//2個空格當間隔
              ShowTagsWidget(),
            ] 
          ),
          SizedBox(height: 5,),
          Row(
            children:[
              ShowTagsWidget(),
              const Text('  '),//2個空格當間隔
              ShowTagsWidget(),
            ] 
          ),
          


        ],
       )
      )
    );
  }
}

class ShowUsedTagsWidget extends StatelessWidget {
    const ShowUsedTagsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 255, 255, 255),//color沒放在decoration裡的話會overflow
      ),
      child: 
      Container(
        child:
        Column( children: [
          Text(
              '曾使用過的專業標籤',
              textAlign: TextAlign.center,
               style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 5,),
          Row(
            children:[
              ShowTagsWidget(),
              const Text('  '),//2個空格當間隔
              ShowTagsWidget(),
            ] 
          ),
          SizedBox(height: 5,),
          Row(
            children:[
              ShowTagsWidget(),
              const Text('  '),//2個空格當間隔
              ShowTagsWidget(),
            ] 
          ),
          


        ],
       )
      )
    );
  }
}





String addtags = "";
int adding_len = 0;

//24.2, 18
//const Color.fromARGB(255, 240, 235, 116),系統認證標籤顏色

//說明頁面按鈕
class InstructionsWiget extends StatelessWidget {
  const InstructionsWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: InkWell(
            onTap:(){
              //-->說明頁面
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePhoneNumberPage()));
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
                  '說明',
                  textAlign: TextAlign.center,
                  style: TextStyle(//letterSpacing: 10,
                  fontSize: 18,
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