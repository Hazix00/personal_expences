import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dart_date/dart_date.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;

  TransactionList(this.transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: <Widget>[
              Text(
                'No transactions yet ...',
                style: theme.textTheme.headline6,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: constraints.maxHeight * .6,
                child: Image.asset('assets/img/waiting.png'),
              )
            ]);
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          '${transactions[index].amount.toStringAsFixed(2)}MAD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '${transactions[index].title}',
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    transactions[index].date.format('yMMMMEEEEd'),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () => delTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: TextButton.styleFrom(
                            primary: theme.errorColor,
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: theme.errorColor,
                          onPressed: () => delTx(transactions[index].id),
                        ),
                ),
              );
            },
          );
  }
}
