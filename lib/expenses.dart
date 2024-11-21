import 'package:flutter/material.dart';
import 'package:flutter_expence_tracker/models/expense.dart';
import 'package:flutter_expence_tracker/widgets/expences_list/expense_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Room Rent",
      amount: 17000,
      date: DateTime.now(),
      category: Category.fixed,
    ),
    Expense(
      title: "Groccery",
      amount: 6000,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "House visit",
      amount: 793,
      date: DateTime.now(),
      category: Category.travel,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Expense Tracker')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Text("Chart Area"),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
