import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pops/design.dart';
import 'package:pops/frontEnd/widgets/alert.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

import '../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  PhoneNumberEditingController phoneNumberController =
      PhoneNumberEditingController();

  @override
  Widget build(BuildContext context) {
    if (AccountManager.isPhoneVerified()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.home);
      });
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
          margin: Design.outsideSpacing,
          width: double.infinity,
          height: double.infinity,
          child: Container(
            padding: Design.outsideSpacing,
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
          Navigator.of(context).pop();
        },
      ),
    );

    if (AccountManager.isPhoneVerified()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.home);
      });
    }
  }
}
