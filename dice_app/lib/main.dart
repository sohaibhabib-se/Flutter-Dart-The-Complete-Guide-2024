import 'package:flutter/material.dart';

import 'package:dice_app/gradient_container.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(body: GradientContainer(
      Color.fromARGB(255, 33, 5, 109),
      Color.fromARGB(255, 68, 21, 149),
    )),
  ));
}

// class GradientContainer extends StatelessWidget {
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [
//           Color.fromARGB(255, 26, 2, 80),
//           Color.fromARGB(255, 45, 7, 98)
//         ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//       ),
//       child: const Center(
//         child: Text(
//           "Hello Systems!!!",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 28,
//           ),
//         ),
//       ),
//     );
//   }
// }
