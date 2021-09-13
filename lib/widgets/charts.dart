import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

import '../models/transaction.dart';
import 'chart-bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  // get the amount in each day in a week
  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double sumAmount = recentTransactions
            .where((tx) => tx.date.isSameDay(weekDay))
            .fold(0, (sum, tx) => sum + tx.amount);

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

  Widget dayChartBar(Map<String, Object> data) {
    final spendPerCnt =
        totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending;
    return Flexible(
      fit: FlexFit.tight,
      child: ChartBar(data['day'], data['amount'], spendPerCnt),
    );
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
            return dayChartBar(data);
          }).toList(),
        ),
      ),
    );
  }
}
