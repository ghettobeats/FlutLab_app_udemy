import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          title: 'Expense App Android',
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
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Prueba', amount: 50.00, date: DateTime.now())
  ];
  bool _showChart = false;
//get a list of transaction resent
  List<Transaction> get recentTransactions => _userTransactions
      .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void _addnewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransactions.add(
        Transaction(
            id: DateTime.now().toString(),
            title: title,
            amount: amount,
            date: date),
      );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar;
    if (Platform.isAndroid) {
      appBar = CupertinoNavigationBar(
        middle: Text('Personal Expenses'),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () => _startAddNewTransaction(context),
            child: Icon(CupertinoIcons.add),
          )
        ]),
      );
    } else {
      appBar = AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(
                Icons.add,
              ))
        ],
      );
    }

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  )
                ],
              ),
            if (!_isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(recentTransactions),
              ),
            if (!_isLandScape) txList,
            if (_isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(recentTransactions),
                    )
                  : txList,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isAndroid
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.amber,
                    onPressed: () => _startAddNewTransaction(context),
                    elevation: 2,
                    tooltip: 'Add Transaction',
                    child: const Icon(
                      Icons.add,
                    )),
          );
  }
}
