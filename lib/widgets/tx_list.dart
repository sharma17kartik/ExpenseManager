import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TxList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
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
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    './assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
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
                      DateFormat('MMM-dd-yyyy').format(transaction[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transaction[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transaction[index].id),
                          ),
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
