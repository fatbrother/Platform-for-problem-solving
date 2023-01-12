import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';

class GoBackBar extends StatelessWidget with PreferredSizeWidget {
  final void Function()? onPop;
  final String? backRoute;

  const GoBackBar({super.key, this.onPop, this.backRoute});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      elevation: 0,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      leading: SizedBox(
        height: kToolbarHeight * 0.7,
        child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              if (onPop != null) {
                onPop!();
              }
              if (backRoute != null) {
                try {
                  Routes.pushReplacement(context, backRoute!);
                  return;
                  // ignore: empty_catches
                } catch (e) {}
              }
              Routes.back(context);
            }),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TitleBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const TitleBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0.1 * Design.getScreenHeight(context),
      titleTextStyle: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Design.primaryColor,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final void Function(String text) onSelected;
  final List<String> Function(String text) getSuggestions;

  SearchBar({
    super.key,
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
          onSelected: onSelected,
          getSuggestions: getSuggestions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AutoCompleteField extends StatelessWidget {
  final void Function(String text) onSelected;
  final List<String> Function(String text) getSuggestions;

  const AutoCompleteField({
    super.key,
    required this.onSelected,
    required this.getSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) =>
          getSuggestions(textEditingValue.text),
      onSelected: onSelected,
      fieldViewBuilder:
          (context, controller, fieldFocusNode, onFieldSubmitted) {
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
              onChanged: (String value) {
                if (value == '') {
                  onSelected(value);
                }
              },
            )),
            IconButton(
              onPressed: () {
                controller.clear();
                onSelected('');
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
              width: Design.getScreenWidth(context) * 0.87,
              child: ListView(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                children: [
                  for (final option in options)
                    ListTile(
                      title: Text(option),
                      onTap: () {
                        onSelected(option);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
