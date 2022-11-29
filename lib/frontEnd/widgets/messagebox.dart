import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';

class Message {
  final String text;
  final bool isMe;
  Message({required this.text, required this.isMe});
}

//Not important just some copies
// class MessageBox extends StatelessWidget {
//   const MessageBox({super.key, required this.text, required this.isMe});
//   final String text;
//   final bool isMe;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //alignment: MessageBox.isMe ? Alignment.centerLeft : Alignment.centerRight,
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         //mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Flexible(
//             child: Container(
//               color: Design.primaryColor,
//               padding: const EdgeInsets.all(10.0),
//               // decoration:
//               //     const BoxDecoration(borderRadius: Design.outsideBorderRadius),
//               child: Text(text,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 5,
//                   style: const TextStyle(fontSize: 18.0, color: Colors.white)),
//             ),
//           ),
//           const Icon(Icons.person, size: 32)
//         ],
//       ),
//     );
//   }
// }


