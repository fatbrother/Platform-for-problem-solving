import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pops/backEnd/problem/problem.dart";

class QuestionApplyPage extends StatelessWidget {
  const QuestionApplyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const BackButton(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(235, 217, 217, 217),
        body: const MyCustomForm(title: 'Flutter Demo Home Page'));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key, required this.title});
  final String title;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  TextEditingController partialAnsController = TextEditingController();
  TextEditingController priceController = TextEditingController();

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
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  //color: Colors.white,
                  child: const Text('標題',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center)),
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
                  controller: partialAnsController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '提供的部分答案與應徵文...',
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
                margin: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 20, right: 20),
                //height: 40,
                child: TextFormField(
                  controller: priceController,
                  textInputAction: TextInputAction.newline,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '應徵價格 (底價NT\$5)',
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
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) <= 5) {
                      return "請輸入比底價高的價格";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                    IconButton(
                      icon: const Icon(FeatherIcons.calendar),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        //padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        //  const EdgeInsets.only(top: 0, bottom:100, left: 0, right: 0))
                        //fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
                      ),
                      //style: ElevatedButton.styleFrom(
                      //  primary: Colors.white,
                      //  onPrimary: Colors.grey,
                      //),
                      onPressed: () async {
                        final date = await pickDate();
                        if (date == null) return; // Press cancal

                        setState(() => dateTime = date); // Press OK
                      },
                    )
                  ],
                ),
              ),
              //TextFormField(
              //  validator: (value) {
              //    if (value == null || value.isEmpty) {
              //      return 'Please enter some text';
              //    }
              //    return null;
              //  },
              //),
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
                    "應徵",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: currentTime,
        firstDate: currentTime,
        lastDate:
            DateTime(currentTime.year, currentTime.month, currentTime.day + 7),
      );
}
