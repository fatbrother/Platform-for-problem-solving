import 'package:flutter/material.dart';

class AddImgRow extends StatelessWidget {
  final void Function() onPressed;

  const AddImgRow({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.image, color: Colors.grey, size: 50),
            Icon(Icons.image, color: Colors.grey, size: 50),
            Icon(Icons.image, color: Colors.grey, size: 50),
          ],
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.add_box_outlined,
              color: Colors.grey, size: 40),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
