import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

final dateFormatter = DateFormat.yMd();

enum Category { food, travel, entertainment, shopping, other, fixed }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.entertainment: Icons.movie,
  Category.shopping: Icons.shopping_bag,
  Category.other: Icons.miscellaneous_services,
  Category.fixed: Icons.gps_fixed
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
