import 'package:flutter/material.dart';
import 'package:dice_app/dice_roller.dart';

import 'package:dice_app/styled_text.dart';

const Alignment startAlignment = Alignment.topLeft;
const Alignment endAlignment = Alignment.bottomRight;

// class GradientContainer extends StatelessWidget {
//
//   const GradientContainer({super.key, required this.gradientColorList});
//
//   final List<Color> gradientColorList;
//
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: gradientColorList, begin: startAlignment, end: endAlignment),
//       ),
//       child: const Center(
//         child: StyledText(),
//       ),
//     );
//   }
// }

// class GradientContainer extends StatelessWidget {
//
//   const GradientContainer({super.key, required this.gradientColorList});
//
//   final List<Color> gradientColorList;
//
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: gradientColorList, begin: startAlignment, end: endAlignment),
//       ),
//       child: const Center(
//         child: StyledText(),
//       ),
//     );
//   }
// }

// class GradientContainer extends StatelessWidget {
//
//   const GradientContainer(this.color1, this.color2, {super.key});
//
//   final Color color1;
//   final Color color2;
//
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [color1, color2], begin: startAlignment, end: endAlignment),
//       ),
//       child: const Center(
//         child: StyledText(),
//       ),
//     );
//   }
// }

// class GradientContainer extends StatelessWidget {
//    GradientContainer(this.color1, this.color2, {super.key});
//
//    GradientContainer.purple({super.key})
//       : color1 = Colors.deepPurple,
//         color2 = Colors.indigo;
//   final Color color1;
//   final Color color2;
//   var activeDiceImage = 'assets/images/dice-2.png';
//
//   void rollDice() {
//     print("Hello");
//     activeDiceImage = 'assets/images/dice-4.png';
//   }
//
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             colors: [color1, color2], begin: startAlignment, end: endAlignment),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               activeDiceImage,
//               width: 200,
//             ),
//             const SizedBox(height: 20,),
//             TextButton(
//                 onPressed: rollDice,
//                 style: TextButton.styleFrom(
//                     // padding: EdgeInsets.only(top: 20),
//                     foregroundColor: Colors.white,
//                     textStyle: const TextStyle(fontSize: 28)),
//                 child: const Text("Roll Dice"))
//           ],
//         ),
//       ),
//     );
//   }
// }

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
      : color1 = Colors.deepPurple,
        color2 = Colors.indigo;
  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color1, color2], begin: startAlignment, end: endAlignment),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
