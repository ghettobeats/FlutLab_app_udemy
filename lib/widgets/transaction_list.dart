import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({required this.userTransactions});

  @override
  Widget build(BuildContext context) => Container(
        height: 300,
        child: userTransactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not Data yet',
                    style: TextStyle(
                      fontFamily: 'Itim',
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
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
                    subtitle: Text(DateFormat.yMMMd()
                        .format(userTransactions[index].date)),
                    trailing: Icon(Icons.menu),
                  ),
                ),
                itemCount: userTransactions.length,
              ),
      );
}
