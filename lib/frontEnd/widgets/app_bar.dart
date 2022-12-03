import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget{
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0),
      leading: SizedBox(
        height: kToolbarHeight * 0.7,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Routes.back(context),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final TextEditingController _textEditingController = TextEditingController();

  SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90,
      backgroundColor: Design.backgroundColor,
      title: Container(
        height: kToolbarHeight * 0.7,
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Design.insideColor,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _textEditingController.clear();
              },
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
