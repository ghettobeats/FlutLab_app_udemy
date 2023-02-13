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
    final appbar = AppBar(
      // The title text which will be shown on the action bar
      title: Text(widget.title),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(
              Icons.add,
            ))
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch(
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
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransactions),
              ),
            if (!_isLandScape) txList,
            if (_isLandScape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(recentTransactions),
                    )
                  : txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
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
