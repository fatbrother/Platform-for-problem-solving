import 'package:flutter/material.dart';
import 'package:pops/single_problem_view.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProblemPage(),
    );
  }
}

class ProblemPage extends StatefulWidget {
  const ProblemPage({super.key});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(79, 128, 155, 5),
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromRGBO(217, 217, 217, 10),
          //preferredSize: const Size.fromHeight(50),
          title: Container(
            padding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
            margin: const EdgeInsets.all(0),
            //height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: SizedBox(
              //  height: 20,
              child: TextField(
                controller: _textEditingController,
                style: const TextStyle(
                  fontSize: 25,
                  height: 1.5,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffix: IconButton(
                      onPressed: _textEditingController.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      )),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
      //   backgroundColor: Color.fromRGBO(200, 217, 217, 100),
      body: const ProblemHomePage(),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (int idx) {},
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.ac_unit,
                  color: Colors.black,
                  size: 24,
                ),
                label: '1'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.accessibility,
                  color: Colors.black,
                  size: 24,
                ),
                label: '2'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.accessibility,
                  color: Colors.black,
                  size: 24,
                ),
                label: '3'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 24,
                ),
                label: '4'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.abc_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                label: '5'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.black,
                  size: 24,
                ),
                label: '6'),
          ],
        ),
      ),
    );
  }
}

class ProblemHomePage extends StatefulWidget {
  const ProblemHomePage({super.key});

  @override
  ProblemHomePageState createState() => ProblemHomePageState();
}

class ProblemHomePageState extends State<ProblemHomePage> {
  List<WidgetBuilder> problemBoxList = [
        (context) => ProbelmBoxIcon(
          str_tile: "problem_title",
          str_name: "name",
          str_time: "上傳時間：",
            icon: const Icon(Icons.info_outline_sharp, color: Colors.white,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
            }),
        (context) => ProbelmBoxIcon(
            str_tile: "problem_title",
            str_name: "name",
            str_time: "答案期限：",
            icon: const Icon(Icons.edit_note_rounded,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
            }),
        (context) => ProbelmBoxIcon(
            str_tile: "problem_title",
            str_name: "name",
            str_time: "下架時間：",
            icon: const Icon(Icons.check_circle_outline_rounded, ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
            }),
        (context) => ProbelmBoxIcon(
            str_tile: "problem_title",
            str_name: "name",
            str_time: "檢舉中",
            icon: const Icon(Icons.error_outline_rounded,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
            }),
        (context) => ProbelmBoxIcon(
            str_tile: "problem_title",
            str_name: "name",
            str_time: "檢舉成功",
            icon: const Icon(Icons.error_outline_rounded, ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
        }),
        (context) => ProbelmBoxIcon(
            str_tile: "problem_title",
            str_name: "name",
            str_time: "檢舉失敗",
            icon: const Icon(Icons.error_outline_rounded,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingleProblemView()));
        }),

  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: problemBoxList
          .map((WidgetBuilder problemBox) => problemBox(context))
          .toList(),
    );
  }
}


class ProbelmBoxIcon extends StatelessWidget {
  final Icon icon;
  final void Function() onTap;
  final String str_time, str_name, str_tile;

  const ProbelmBoxIcon({super.key, required this.icon, required this.onTap, required this.str_time, required this.str_name, required this.str_tile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5.0,
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromRGBO(79, 128, 155, 100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          str_tile,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    //   height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            right: 15, left: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.accessibility_new_rounded),
                            Text(
                              str_name,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.access_time_rounded),
                            Text(
                              str_time,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      icon,
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}


