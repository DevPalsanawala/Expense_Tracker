// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:expense_tracker/Wigets/expense_list/expenselist_item.dart';
import 'package:expense_tracker/models/expene.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpenses,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.70),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expense: expenses[index]),
        onDismissed: (direction) {
          onRemoveExpenses(expenses[index]);
        },
      ),
    );
  }
}
