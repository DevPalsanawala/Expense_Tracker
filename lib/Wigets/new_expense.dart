// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker/models/expene.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expene.dart' as exp;

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.onAddExpense}) : super(key: key);

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  exp.Category _selectedCategory = exp.Category.food;

  void _showDatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstdate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickeddate;
    });
  }

  void _submitExpenseData() {
    final _enterAmount = double.tryParse(_amountController.text);
    final _amountIsinvalid = _enterAmount == null || _enterAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        _amountIsinvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure a valid title,amount,date and category was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: _enterAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keybordspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 80, 16, keybordspace + 16),
              child: Center(
                child: Column(
                  children: [
                    if (width >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              maxLength: 50,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                label: const Text("Title"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: const Text("Amount"),
                                prefixText: '₹ ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        controller: _titleController,
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: const Text("Title"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    if (width >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DropdownButton(
                              value: _selectedCategory,
                              items: exp.Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
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
                              }),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? "No Date Selected"
                                      : exp.formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: _showDatepicker,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: const Text("Amount"),
                                prefixText: '₹ ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? "No Date Selected"
                                      : exp.formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: _showDatepicker,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (width >= 600)
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                // shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancle"),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                // shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _submitExpenseData,
                              child: const Text("Save Expense"),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                              value: _selectedCategory,
                              items: exp.Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
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
                              }),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                // shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancle"),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                // shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _submitExpenseData,
                              child: const Text("Save Expense"),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
