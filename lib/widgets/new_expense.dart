import 'package:flutter/material.dart';
import 'package:flutter_expence_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.other;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseDate() {
    final amount = double.tryParse(_amountController.text);
    final enteredAmount = amount == null || amount <= 0;

    if (_titleController.text.trim().isEmpty ||
        enteredAmount ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid Input'),
                content: Text('Please fill all the fields'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'))
                ],
              ));
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: amount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(label: Text('Title')),
              ),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    maxLength: 50,
                    decoration: InputDecoration(
                        prefixText: '\u{20B9}', label: Text('Amount')),
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
                        : dateFormatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.calendar_month))
                  ],
                ))
              ]),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCategory = value;
                        });
                      }),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenseDate,
                      child: Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
