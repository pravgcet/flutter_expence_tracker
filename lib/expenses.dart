import 'package:flutter/material.dart';
import 'package:flutter_expence_tracker/models/expense.dart';
import 'package:flutter_expence_tracker/widgets/chart/chart.dart';
import 'package:flutter_expence_tracker/widgets/expences_list/expense_list.dart';
import 'package:flutter_expence_tracker/widgets/new_expense.dart';

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

  void _addExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expense Deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No Expense found. Start Adding expenses.'),
    );

    final width = MediaQuery.of(context).size.width;

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Expense Tracker')),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: _registeredExpenses,
                ),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(this.category, List<Expense> allExpenses)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
