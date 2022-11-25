import 'package:flutter/material.dart';

class AddProblemPage extends StatelessWidget{
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
                  margin: const EdgeInsets.all(20),
                  //height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    //  height: 20,
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 17,
                      //  height: 1,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '題目標題',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
              onPressed: (){},
              child: Text('確認選擇', style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(79, 128, 155, 100),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
          ),
        ],
      ),
    );
  }

}