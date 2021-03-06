import 'package:flutter/material.dart';

import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/charts.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

const String AppTitle = 'Personal Expenses';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTitle,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.teal,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // a list of hard coded transactions
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'New Jachet',
      amount: 40.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'New Jachet',
      amount: 40.00,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't6',
      title: 'New Jachet',
      amount: 40.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];
  // get transactions for today and 6 days before
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // adding new transaction with a modal
  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  // delete transaction method
  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // set appBar in a variable to calculate the body height
    final appBar = AppBar(
      title: Text(AppTitle),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(),
        ),
      ],
    );
    final mediaQuery = MediaQuery.of(context);
    // calc body height = screen height - appbar height - status bar height
    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: bodyHeight * .24, // 24% of the body height for the Chart
            child: Chart(_recentTransactions),
          ),
          Container(
            height: bodyHeight * .76, // 76% of the body height for the transaction list
            child: TransactionList(
              _userTransactions,
              _deleteTransaction,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
