import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
          itemBuilder: (_, index) => Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text("\$${userTransactions[index].amount}")),
                ),
              ),
              title: Text(userTransactions[index].title,
                  style: Theme.of(context).textTheme.bodyLarge),
              subtitle:
                  Text(DateFormat.yMMMd().format(userTransactions[index].date)),
              trailing: MediaQuery.of(context).size.width > 360
                  ? TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).errorColor,
                      ),
                      child: Icon(Icons.delete),
                      onPressed: () =>
                          deleteTransaction(userTransactions[index].id),
                    )
                  : IconButton(
                      onPressed: () =>
                          deleteTransaction(userTransactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
            ),
          ),
          itemCount: userTransactions.length,
        );
}
