import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onremoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveExpense;

  @override
  Widget build(BuildContext context) {
    // Adding Dissmissible to delete the item on swipe
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.85),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) {
              onremoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index]),
          )),
    );
  }
}
