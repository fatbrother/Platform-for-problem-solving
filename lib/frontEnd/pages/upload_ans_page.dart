// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

//void main() => runApp(const MyApp());

class UploadAnsPage extends StatelessWidget {
  const UploadAnsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
              title: const BackButton(color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0),
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromARGB(235, 217, 217, 217),
          body: const MyCustomForm()),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  //const MyCustomForm({super.key});
  const MyCustomForm({super.key});
  //final String title;

  @override
  State<MyCustomForm> createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  // ignore: non_constant_identifier_names
  TextEditingController PartialAnsController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController PriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                          height: 40,
                          child: Text('標題',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Spacer(flex: 50),
                          Icon(FeatherIcons.clock),
                          Spacer(flex: 1),
                          Text("RemainDays",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                          Spacer(flex: 50)
                        ],
                      )
                    ]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0)),
                          border: Border.all(color: Colors.white)),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 2.5, left: 10, right: 10),
                      margin: const EdgeInsets.only(
                          top: 15, bottom: 0, left: 20, right: 20),
                      child: const Text('題目標題',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start)),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                          border: Border.all(color: Colors.white)),
                      padding: const EdgeInsets.only(
                          top: 2.5, bottom: 5, left: 10, right: 10),
                      margin: const EdgeInsets.only(
                          top: 0, bottom: 15, left: 20, right: 20),
                      child: const Text('題目描述',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 20, height: 2.0),
                          textAlign: TextAlign.start))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0)),
                          border: Border.all(color: Colors.white)),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 2.5, left: 10, right: 10),
                      margin: const EdgeInsets.only(
                          top: 15, bottom: 0, left: 20, right: 20),
                      child: const Text(
                        '需求',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      )),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                          border: Border.all(color: Colors.white)),
                      padding: const EdgeInsets.only(
                          top: 2.5, bottom: 5, left: 10, right: 10),
                      margin: const EdgeInsets.only(
                          top: 0, bottom: 15, left: 20, right: 20),
                      child: const Text('需求描述',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          textAlign: TextAlign.start))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 20, right: 20),
                //height: 40,
                child: TextFormField(
                  controller: PartialAnsController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '輸入答案...',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    isDense: true,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "此欄位不可空白";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(198, 192, 220, 236),
                    borderRadius: BorderRadius.circular(20.0)),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(198, 192, 220, 236)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text(
                    "上傳",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
