// Creating a model of Expense to intitalize value of added expenses in the app
// We are using a uuid package to add unique id to a expense
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

// WE can create a enum type values Category so that users can select which
// Kind of expense was added, by defalue the values inside the enum treated as String
enum Category { food, travelling, work, leisure }

// Creating a const to store the Icons for the Selected category as key value pairs
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travelling: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  // Initialize the values
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  // Here uuid.v4() gaves a value to id whenever this Expense class calls
  // Creating Instances of class
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  // Added a custom enum value Category to precise the values later

  // Making a Get Method to edit the date using intl Package of flutter
  String get formattedDate {
    return formatter.format(date);
  }
}

// Making a another class to sum up Total Amount of a Category to show them in charts
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  // Making a contructor function to filter out the expense of a specific category
  ExpenseBucket.forCategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((element) => element.category == category)
            .toList();

  // using a For in loop to sum up the category amount
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
