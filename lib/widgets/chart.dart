import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTx;
  Chart(this.recentTx);

  List<Map<String, Object>> get groupTx {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year)
          totalSum += recentTx[i].amount;
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalAmount {
    return groupTx.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupTx);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTx.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx['day'],
                tx['amount'],
                totalAmount == 0.0
                    ? 0.0
                    : (tx['amount'] as double) / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
