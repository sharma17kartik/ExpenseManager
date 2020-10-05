import 'package:flutter/material.dart';

import './widgets/tx_list.dart';
import './widgets/new_tx.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transaction = [
    // Transaction(
    //   id: 'P1',
    //   amount: 110,
    //   title: 'New Shoes',
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'P2',
    //   amount: 100,
    //   title: 'New Jacket',
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get recentTx {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addTx(String titleTx, double amountTx, DateTime date) {
    final newTxData = Transaction(
      amount: amountTx,
      title: titleTx,
      date: date,
      id: DateTime.now().toString(),
    );
    setState(() {
      transaction.add(newTxData);
    });
  }

  void startNewTxt(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTx(_addTx),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTx(String id) {
    setState(() {
      transaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startNewTxt(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTxt(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTx),
            TxList(transaction, deleteTx),
          ],
        ),
      ),
    );
  }
}
