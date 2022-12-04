import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/tag.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {
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
  final TextEditingController textEditingController;
  final void Function() onSelected;
  final List<String> Function(String text) getSuggestions;

  SearchBar({
    super.key,
    required this.textEditingController,
    required this.onSelected,
    required this.getSuggestions,
  });

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
        child: AutoCompleteField(
          controller: textEditingController,
          onSelected: onSelected,
          getSuggestions: getSuggestions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AutoCompleteField extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onSelected;
  final List<String> Function(String text) getSuggestions;

  const AutoCompleteField({
    super.key,
    required this.controller,
    required this.onSelected,
    required this.getSuggestions,
  });

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  List<String> _suggestions = [];

  Future<void> findSuggestions(String text) async {
    _suggestions = widget.getSuggestions(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        await findSuggestions(textEditingValue.text);
        return _suggestions;
      },
      onSelected: (String selection) {
        widget.controller.text = selection;
        widget.onSelected();
      },
      fieldViewBuilder: (context, controller, FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return Row(
          children: [
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
                child: TextFormField(
              controller: controller,
              focusNode: fieldFocusNode,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            )),
            IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ],
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            color: Design.insideColor,
            borderRadius: Design.outsideBorderRadius,
            child: SizedBox(
              height: 200,
              width: Design.getScreenWidth(context) * 0.87,
              child: ListView(padding: const EdgeInsets.all(0), children: [
                for (final option in options)
                  ListTile(
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
                    },
                  ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
