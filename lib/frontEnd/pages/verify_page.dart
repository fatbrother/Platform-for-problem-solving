import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

import '../routes.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  PhoneNumberEditingController phoneNumberController =
      PhoneNumberEditingController();

  @override
  Widget build(BuildContext context) {
    if (AccountManager.isPhoneVerified()) {
      Routes.back(context);
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Design.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 0.1 * Design.getScreenHeight(context),
          titleTextStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Design.primaryColor,
          title: const Text('Verify Page'),
        ),
        body: Container(
          margin: Design.spacing,
          width: double.infinity,
          height: double.infinity,
          child: Container(
            padding: Design.spacing,
            decoration: const BoxDecoration(
              color: Design.secondaryColor,
              borderRadius: Design.outsideBorderRadius,
            ),
            child: Column(
              children: [
                PhoneNumberField(
                  controller: phoneNumberController,
                ),
                const SizedBox(height: 10.0),
                MainButton(
                  onPressed: () => sendSms(),
                  text: 'Send Verification SMS',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendSms() async {
    String phoneNumber = phoneNumberController.toString();
    String verificationId = '';
    try {
      verificationId = await AccountManager.sendSms(phoneNumber);
    } catch (e) {
      DialogManager.showError(e, context);
      return;
    }

    TextEditingController smsCodeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Alert(
        title: 'Verification SMS Sent',
        content: TextField(
          controller: smsCodeController,
          decoration: const InputDecoration(
            hintText: 'Enter Verification Code',
          ),
        ),
        onPressed: () {
          String smsCode = smsCodeController.text;
          try {
            AccountManager.verifyPhoneNumber(verificationId, smsCode);
          } catch (e) {
            DialogManager.showError(e, context);
          }
        },
      ),
    );
    setState(() {});
  }
}
