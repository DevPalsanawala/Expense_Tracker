// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// intl class properties which generate the formated date

final formatter = DateFormat.yMd();

// uuid class object generate unique ids
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formateddate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

class totalExpenseAmount {
  final List<Expense> expenses;
  totalExpenseAmount({
    required this.expenses,
  });

  double get totalAmount {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
