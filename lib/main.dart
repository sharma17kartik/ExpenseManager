import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import './widgets/tx_list.dart';
import './widgets/new_tx.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.green,
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

  bool _showChart = false;

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Expense Manager'),
      actions: [
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () => startNewTxt(context),
        )
      ],
    );

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TxList(transaction, deleteTx),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTxt(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTx),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(recentTx),
                    )
                  : txListWidget,
            Text(
              'Made By Kartik Sharma',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
