import 'package:expense_tracker/widgets/chats/charts.dart';
import 'package:expense_tracker/widgets/expense_input.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() {
    return _ExpenseTeackerState();
  }
}

class _ExpenseTeackerState extends State<ExpenseTracker> {
  // Creating a dummy data of Expenses to show it in a list form on screen //
  final List<Expense> _items = [];

  // making a function to open bottom Sheet to input values
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpenseInput(onAddExpense: _addExpenses),
    );
  }

  // Adding the Expense item
  void _addExpenses(Expense expense) {
    setState(() {
      _items.add(expense);
    });
  }

  // Removing the expense Item
  void _removeExpense(Expense expense) {
    // Getting the Index where to put the expense back on press Undo
    final index = _items.indexOf(expense);

    setState(() {
      _items.remove(expense);
    });

    // Clearing the prev SnackBar if any
    ScaffoldMessenger.of(context).clearSnackBars();
    // Showing a Message on deleting the expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _items.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the height and width of device dynamically like Dimensions in React Native using media Queries
    final width = MediaQuery.of(context).size.width;

    // Showing a message if no value is present in _items
    Widget mainContent = const Center(
      child: Text('No Expense Found, Start Adding Some!'),
    );

    if (_items.isNotEmpty) {
      mainContent =
          ExpenseList(expenses: _items, onremoveExpense: _removeExpense);
    }
    return Scaffold(
      // Adding a appBar on top to show the Stack Bar on Top
      // By default it is Material 2 to make it material 3 we add a line in main MaterialApp
      appBar: AppBar(title: const Text('Expense Manager'), actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
      ]),
      body: width < 500
          ? Column(
              children: [
                Chart(expenses: _items),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _items),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
