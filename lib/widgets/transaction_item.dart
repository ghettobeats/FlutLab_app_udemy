import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(child: Text("\$${userTransaction.amount}")),
          ),
        ),
        title: Text(userTransaction.title,
            style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(DateFormat.yMMMd().format(userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                child: Icon(Icons.delete),
                onPressed: () => deleteTransaction(userTransaction.id),
              )
            : IconButton(
                onPressed: () => deleteTransaction(userTransaction.id),
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
