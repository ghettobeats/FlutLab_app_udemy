import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) => userTransactions.isEmpty
      ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [
              const Text(
                'No Transactions added yet',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: constraints.maxHeight * 0.7,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
        })
      : ListView.builder(
          itemBuilder: (ctx, index) => TransactionItem(
            userTransaction: userTransactions[index],
            deleteTransaction: deleteTransaction,
          ),
          itemCount: userTransactions.length,
        );
}
