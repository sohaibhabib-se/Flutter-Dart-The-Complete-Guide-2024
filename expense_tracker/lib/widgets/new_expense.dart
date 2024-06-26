import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog(){
    //Show error message
    if(Platform.isIOS) {
      showCupertinoDialog(context: context, builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Invalid Input"),
        content: const Text(
          'Please make sure a valid, title, amount, date and category was entered.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Ok'),
          ),
        ],
      ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
            'Please make sure a valid, title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
_showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext build) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      // print(constraints.minWidth);
      // print(constraints.maxWidth);
      // print(constraints.minHeight);
      // print(constraints.maxHeight);

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            //const EdgeInsets.fromLTRB(16, 48, 16, 16),//.all(16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          // onChanged: _saveTitleInput,
                          controller: _titleController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text("Title")),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixText: '\$ ', label: Text("Amount")),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    // onChanged: _saveTitleInput,
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                if(width >= 600)
                  Row(children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    SizedBox(width: 24,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],)
                else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: '\$ ', label: Text("Amount")),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if(width >= 600)
                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      /**() {
                          // print(_enteredTitle);
                          print(_titleController.text);
                          print(_amountController.text);
                          },*/
                      child: const Text("Save Expense"),
                    ),
                  ],)
                else
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      /**() {
                          // print(_enteredTitle);
                          print(_titleController.text);
                          print(_amountController.text);
                          },*/
                      child: const Text("Save Expense"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

    // return SizedBox(
    //   height: double.infinity,
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),//const EdgeInsets.fromLTRB(16, 48, 16, 16),//.all(16),
    //       child: Column(
    //         children: [
    //           TextField(
    //             // onChanged: _saveTitleInput,
    //             controller: _titleController,
    //             maxLength: 50,
    //             decoration: const InputDecoration(label: Text("Title")),
    //           ),
    //           Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   controller: _amountController,
    //                   keyboardType: TextInputType.number,
    //                   decoration: const InputDecoration(
    //                       prefixText: '\$ ', label: Text("Amount")),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 16,
    //               ),
    //               Expanded(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       _selectedDate == null
    //                           ? 'No date selected'
    //                           : formatter.format(_selectedDate!),
    //                     ),
    //                     IconButton(
    //                       onPressed: _presentDatePicker,
    //                       icon: const Icon(
    //                         Icons.calendar_month,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 16,
    //           ),
    //           Row(
    //             children: [
    //               DropdownButton(
    //                 value: _selectedCategory,
    //                 items: Category.values
    //                     .map(
    //                       (category) => DropdownMenuItem(
    //                         value: category,
    //                         child: Text(
    //                           category.name.toUpperCase(),
    //                         ),
    //                       ),
    //                     )
    //                     .toList(),
    //                 onChanged: (value) {
    //                   if (value == null) {
    //                     return;
    //                   }
    //                   setState(() {
    //                     _selectedCategory = value;
    //                   });
    //                 },
    //               ),
    //               const Spacer(),
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child: const Text("Cancel"),
    //               ),
    //               ElevatedButton(
    //                 onPressed: _submitExpenseData,
    //                 /**() {
    //                     // print(_enteredTitle);
    //                     print(_titleController.text);
    //                     print(_amountController.text);
    //                     },*/
    //                 child: const Text("Save Expense"),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
