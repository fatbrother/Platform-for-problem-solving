import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pops/backEnd/problem/problem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  final controller = ScrollController();
  List<String> items = [];
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();

    fetch();

    controller.addListener(() { 
      if (controller.position.maxScrollExtent == controller.offset){
        fetch();

      }
    });
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  Future fetch() async{
    if (isLoading) return;
    isLoading = true;

    const limit = 25;
    //final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=$limit&page=$page');
    //final response = await http.get(url);

    //if (response.statusCode == 200){
    //  final List newItems = json.decode(response.body);
    final Future<List<ProblemsModel>> newItems = ProblemsDatabase.queryAllProblems();

      setState(() {
        page++;
        isLoading = false;

        late Future<int> lengthOfData;
        
        Future<int> getFileLength() async{
          return await ProblemsDatabase.queryAllProblems().then((value) {
            return value.length;
          });
        }

        //if (newItems.length < limit){
        //  hasMore = false;
        //}
        int len = 0;
        getFileLength().then((value) => len = value);
        if ( len < limit ){
          hasMore = false;
        }

        //items.addAll(newItems.map<String>((item){
        //  final number = item['id'];

        //  return 'Item $number';
        //}).toList());
      //});
    });
  }

  Future refresh() async{
    setState((){
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Infinite Scroll ListView')
    ),
    body: RefreshIndicator( 
      onRefresh: refresh,
      child: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8),
        itemCount: items.length + 1,
        itemBuilder: (context, index){
          if (index < items.length){
            final item = items[index];

            return ListTile(title: Text(item));
          }else{
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: hasMore
                  ? const CircularProgressIndicator()
                  : const Text('No more data to load'),
              ),
            );
          }
        },
      )
    )
  );
}

