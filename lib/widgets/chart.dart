import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getList => List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;

        recentTransactions.forEach((element) {
          if (element.date.day == weekDay.day &&
              element.date.month == weekDay.month &&
              element.date.year == weekDay.year) {
            totalSum += element.amount;
          }
        });
        return {'Day': DateFormat.E().format(weekDay), 'amount': totalSum};
      });

  @override
  Widget build(BuildContext context) {
    print(getList);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: []),
    );
  }
}
