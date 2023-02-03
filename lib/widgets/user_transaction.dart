import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
    Transaction(
        id: DateTime.now().toString(), title: 'platanos', amount: 50.00),
  ];

  void _addnewTransaction(String title, double amount) {
    final txUser = new Transaction(
        id: DateTime.now().toString(), title: title, amount: amount);
    setState(() {
      _userTransactions.add(txUser);
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          NewTransaction(_addnewTransaction),
          TransactionList(userTransactions: _userTransactions),
        ],
      );
}
