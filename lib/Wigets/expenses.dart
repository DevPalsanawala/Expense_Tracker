import 'package:expense_tracker/Wigets/expense_list/expense_list.dart';
import 'package:expense_tracker/Wigets/new_expense.dart';
import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/models/expene.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registorExpense = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
    );
  }

  void _addExpenses(Expense expense) {
    setState(() {
      _registorExpense.add(expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final expenseindex = _registorExpense.indexOf(expense);
    setState(() {
      _registorExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registorExpense.insert(expenseindex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final totalExpense = totalExpenseAmount(expenses: _registorExpense);
    totalExpenseAmount totalExpense =
        totalExpenseAmount(expenses: _registorExpense);
    double total = totalExpense.totalAmount;
    Widget Maincontent = const Center(
      child: Text("No Expenses yet"),
    );

    if (_registorExpense.isNotEmpty) {
      Maincontent = ExpensesList(
        expenses: _registorExpense,
        onRemoveExpenses: _removeExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
        ),
      ),
      body: width < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chart(
                  expenses: _registorExpense,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 16),
                  child: Text('Total Expenses = Rs.${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Expanded(
                  child: Maincontent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Chart(
                        expenses: _registorExpense,
                      ),
                      Text('Total Expenses = Rs.${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                Expanded(
                  child: Maincontent,
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: const Icon(Icons.add),
      ),
    );
  }
}
