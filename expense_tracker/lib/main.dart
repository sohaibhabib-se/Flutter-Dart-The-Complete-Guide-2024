import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      home: Expenses(),
    ),
  );
}