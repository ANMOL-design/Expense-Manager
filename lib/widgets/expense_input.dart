import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseInput extends StatefulWidget {
  const ExpenseInput({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<ExpenseInput> createState() {
    return _ExpenseInputState();
  }
}

class _ExpenseInputState extends State<ExpenseInput> {
  // This is one way of entering Input using the TextField
  // var _enteredTitle = '';

  // void _setInputTitle(String input) {
  //   _enteredTitle = input;
  // }

  // **** We can use the Build in Text Editing Controller to mage input value of text ****//
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  // Define a variable to store the Dropdown value selected
  var _selectedDrop = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Try to Implement Submit Button functionality
  // Firstly it checks that and Input is invalid or not then submitted it
  void _submitExpense() {
    // Convert String amount to double value
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // Return a ERROR message using a built in function showDialog
      showDialog(
          context: context,
          builder: ((ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid title, amount, date and category was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              )));

      return;
    }
    // Submit Expense in Function
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedDrop),
    );
    Navigator.pop(context);
  }

  // We are deleting this Controlled on Closing the Model to optimize or manage memory //
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adding a method the adjust the view in landscape for keyboard
    // Gave the item overlap the screen from Bottom
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, keyboard + 18),
          child: Column(
            children: [
              TextField(
                // onChanged: _setInputTitle,
                controller: _titleController,
                maxLength: 50,
                // keyboardType: TextInputType.number,
                // Gave a Lable to the input box
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'Select Date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Adding a dropdown to select the Category
                    DropdownButton(
                        value: _selectedDrop,
                        items: Category.values
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedDrop = value;
                          });
                        }),

                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        //  We are using build in Naviagtor to POP this Modal on press cancel
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      onPressed: _submitExpense,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
