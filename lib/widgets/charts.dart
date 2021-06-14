import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

import '../models/transaction.dart';
import 'chart-bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double sumAmount = 0.0;
        for (var transaction in recentTransactions) {
          if (transaction.date.isSameDay(weekDay)) {
            sumAmount += transaction.amount;
          }
        }
        return {
          'day': weekDay.format('E'),
          'amount': sumAmount,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionsValues.map((data) {
            final spendPerCnt = totalSpending == 0.0
                ? 0.0
                : (data['amount'] as double) / totalSpending;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'], spendPerCnt),
            );
          }).toList(),
        ),
      ),
    );
  }
}
