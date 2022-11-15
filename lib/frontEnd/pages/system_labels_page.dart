import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/tag.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = '系統標籤';
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

        body: SystemLabelsView(),
      ),
    );
  }
}
class SystemLabelsView extends StatefulWidget {
  SystemLabelsView({super.key});

  @override
  State<SystemLabelsView> createState() => _SystemLabelsViewState();
}

class _SystemLabelsViewState extends State<SystemLabelsView> {
  List<String> tags = <String>['目補習班自然老師','目補習班數學老師','未補習班國文老師','目學校國文老師','失2022/4/5提交','中2022/11/12提交'];
  int count = 0;//for tagsbox
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: Column(
        children: <Widget>[
          //顯示的系統標籤
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(
                  255, 255, 255, 255), //color沒放在decoration裡的話會overflow
            ),
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  '目前顯示的系統標籤',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  direction: Axis.horizontal,
                  children: [
                    for (final tag in tags) if(tag[0] == '目')//只顯示「目前有顯示的」
                      ShowTagsWidget(title: tag.substring(1)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ),
          const SizedBox(height: 19),
          //系統標籤狀態表
          Container(//外白框
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:const Color.fromARGB(255, 255, 255, 255),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Container(//審核通過的標籤
                    width: 370,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:const Color.fromARGB(198, 192, 220, 236),
                    ),
                    child:
                      Column(
                        children: [
                          const Text(//標題
                          '審核通過的標籤',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                          const SizedBox(height: 10),
                          //審核通過的-->有'目前已顯示'及'未顯示'兩種，都列出
                            for(count = 0;count<tags.length;count++)
                              if(tags[count][0] == '目' || tags[count][0] == '未')
                                ShowSystemTableBox(tags[count], count),
                        ],
                      ),
                  ),

                  const SizedBox(height: 10),//空

                  Container(//審核失敗的標籤
                    width: 370,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:const Color.fromARGB(198, 192, 220, 236),
                    ),
                    child:
                      Column(
                        children: [
                          const Text(//標題
                          '審核失敗的標籤',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                          const SizedBox(height: 10),
                          //列出審核失敗的標籤
                            for(count = 0;count<tags.length;count++)
                              if(tags[count][0] == '失')
                                ShowSystemTableBox(tags[count], count),
                        ],
                      ),
                  ),

                  const SizedBox(height: 10),//空

                  Container(//審核中的標籤
                    width: 370,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:const Color.fromARGB(198, 192, 220, 236),
                    ),
                    child:
                      Column(
                        children: [
                          const Text(//標題
                          '審核中的標籤',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                          const SizedBox(height: 10),
                          //列出審核中的標籤
                          for(count = 0;count<tags.length;count++)
                            if(tags[count][0] == '中')
                              ShowSystemTableBox(tags[count], count),
                        ],
                      ),
                  ),
                ],
              ),
          ),
          const SizedBox(height: 19),
        ],
      ),
    );
  }

  Widget ShowSystemTableBox(String tag, int count)
  {
    return Column(
        children: [
          Container(
            width: 370,
            height: 40,
            //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              color:Color.fromARGB(255, 255, 255, 255),
            ),

            child: Stack(
              children: [
                Container(
                  alignment: const Alignment(-1, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                        tag.substring(1),
                        textAlign: TextAlign.center,
                        style: const TextStyle(//letterSpacing: 10,
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                ),

                Container(
                  alignment: const Alignment(0.4, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextButton(
                    onPressed: (){
                      if(tag[0] == '目') {
                        setState(() {
                          //print(tags[count]);
                          tags[count] = tag.replaceRange(0, 1, '未');
                          //print(tags[count]);
                        });
                      } else if(tag[0] == '未') {
                        setState(() {
                          //print(tags[count]);
                          tags[count] = tag.replaceRange(0, 1, '目');
                          //print(tags[count]);
                        });
                      }
                      else if(tag[0] == '失')
                      {

                      }
                      else if(tag[0] == '中')
                      {

                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
                      padding: const EdgeInsets.all(0.0),
                    ),
                    child: LeftButton(state: tag[0],),
                  ),
                ),

                Container(
                  alignment: const Alignment(1, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  //padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  //height: 36,
                  child: TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 210, 209),
                      padding: const EdgeInsets.all(0.0),
                    ),
                    child: const Text('刪除',
                      style: TextStyle( 
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                      )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),//間距
        ],
      );
  }
}


class LeftButton extends StatelessWidget
{
  final String state;
  const LeftButton({super.key, required this.state});
  @override
  Widget build(BuildContext context)
  {
    switch(state)
    {
      case '目': return const Text('隱藏',
                    style: TextStyle( 
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    )
                  );
      case '未': return const Text('顯示',
                    style: TextStyle( 
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    )
                  );
      case '失': return const Text('查看',
                    style: TextStyle( 
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    )
                  );
      case '中': return const Text('查看',
                    style: TextStyle( 
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    )
                  );   
      default: return const Text('LeftButton is error!');
    }
  }
}