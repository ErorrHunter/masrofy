import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showChart = false;
  final List<Transaction> _userTran = [
    Transaction(id: 't1', title: 'new phone', amount: 30, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'new Shirt',
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
  ];

  void deleteTran(String id) {
    setState(() {
      _userTran.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTran(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: date,
        id: DateTime.now().toString());
    setState(() => _userTran.add(newTx));
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTran),
          );
        });
  }

  List<Transaction> get recentUserTran {
    return _userTran.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar = AppBar(
      title: Text('Masrofy'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
final txList= Container(
    height: (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top) *
        0.6,
    child: TransactionList(_userTran, deleteTran));
    return MaterialApp(
        home: Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show chart'),
                Switch(
                  value: showChart,
                  onChanged: (val) {
                    setState(() {
                      showChart = val;
                    });
                  },
                )
              ],
            ),
if(!isLandscape)Container(
    height: (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top) *
        0.3,
    child: Container(child: Chart(recentUserTran))),
  if(!isLandscape)txList,
  if(isLandscape)showChart?
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Container(child: Chart(recentUserTran)))
            :txList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    ));
  }
}
