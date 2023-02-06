import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udemyappflutter/widgets/chart.dart';
import 'package:udemyappflutter/widgets/new_transaction.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        // Application name
        title: 'Flutter Hello World',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Itim',
          // appBarTheme: AppBarTheme(
          //   titleTextStyle: TextStyle(
          //     fontFamily: 'Itim',
          //     fontSize: 28,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //   ),
          // ),
        ),
        // A widget which will be started on application startup
        home: MyHomePage(
          title: 'Udemy App',
        ),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput = '';
  final List<Transaction> _userTransactions = [];

//get a list of transaction resent
  List<Transaction> get recentTransactions => _userTransactions
      .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void _addnewTransaction(String title, double amount) {
    setState(() {
      _userTransactions.add(
        Transaction(
            id: DateTime.now().toString(), title: title, amount: amount),
      );
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
          child: NewTransaction(_addnewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chart(recentTransactions),
              TransactionList(userTransactions: _userTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () => _startAddNewTransaction(context),
            elevation: 2,
            tooltip: 'Add Transaction',
            child: const Icon(
              Icons.add,
            )),
      );
}
