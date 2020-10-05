import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TxList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'No transactions added yet...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    './assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 40,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: FittedBox(
                              child: Text('\$${transaction[index].amount}'),
                            ),
                          )),
                      title: Text(
                        transaction[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat('MMM-dd-yyyy')
                            .format(transaction[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transaction[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
