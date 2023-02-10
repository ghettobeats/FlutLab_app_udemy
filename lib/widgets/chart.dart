import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

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
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      }).reversed.toList();
  double get totalSpending =>
      getList.fold(0.0, (sum, item) => sum + (item['amount'] as double));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getList.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'] as String,
                  data['amount'] as double,
                  totalSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
