import 'package:flutter/material.dart';
import 'package:adv_basics/data//questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;

  // List<Map<String, Object>> getSummaryData() {
  //   final List<Map<String, Object>> summary = [];
  //
  //   for (var i = 0; i < chosenAnswers.length; i++) {
  //     summary.add(
  //       {
  //         'question_index': i,
  //         'question': questions[i].text,
  //         'correct_answer': questions[i].answers[0],
  //         'user_answer': chosenAnswers[i],
  //       },
  //     );
  //   }
  //
  //   return summary;
  // }

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }

    return summary;
  }

  final void Function() onRestart;

  @override
  Widget build(BuildContext context) {
    // final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    // final numCorrectQuestions = summaryData.where((data) {
    //   return data['correct_answer'] == data['user_answer'] ? true : false;
    // }).length;
    final numCorrectQuestions = summaryData
        .where(
            (data) =>  data['correct_answer'] == data['user_answer'],
    )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: const Color.fromARGB(
                    255, 230, 200, 253), //Color.fromARGB(a, r, g, b),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              label: const Text('Restart Quiz'),
              icon: const Icon(Icons.refresh),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
