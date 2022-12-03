import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/pages/user/rate_page.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class ApplicationProfile extends StatelessWidget {
  const ApplicationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.secondaryColor,
              ),
              height: 670,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text('name'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 0),
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.error_outline_rounded),
                                const Text('2'),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.star_border_rounded),
                                const Text('3.5'),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RatePage()));
                                },
                                icon: const Icon(Icons.navigate_next_rounded)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                            '自我介紹kfokosekfoksorkofskorkofksofekrofksopkrofksokrofskrofkoskrokfoskfokrokefspkrfoskrs'),
                      ),
                      Container(
                        padding: Design.spacing,
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                            '部分答案kakofakeokfoawkfokoekfokaeofkaowekfoakowekfowkeofkaowekfokawoekfoawkfokaoekfowkefoakwefkoawkeof'),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_money_rounded),
                            const Text('price')
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  DialogManager.showContentDialog(
                    context,
                    const Text('選擇後將收取代幣。'),
                    () {
                      DialogManager.showInfoDialog(context, '付款成功!',
                          onOk: () => Routes.back(context));
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Design.secondaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: Design.outsideBorderRadius)),
                child: const Text(
                  '確認選擇',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ));
  }
}
