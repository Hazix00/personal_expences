import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * .15, // 15% height for price text
              child: FittedBox(
                child: Text('${spendingAmount.toStringAsFixed(0)}MAD'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * .05,
              ), // 5% margin top and buttom
              height: constraints.maxHeight * .6, // 60% height for the bar
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * .15, // 15% height for day text
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
