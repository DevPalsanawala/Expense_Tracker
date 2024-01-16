// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expene.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '\Rs. ${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(expense.formateddate),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(categoryIcons[expense.category]),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
