import 'package:estacionamento_app/models/transaction.dart';
import 'package:estacionamento_app/screens/home/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    final weekDays = List.generate(
        7, (index) => DateTime.now().subtract(Duration(days: index)));

    return weekDays
        .map((weekDay) {
          double totalSum = 0.0;

          for (var transaction in recentTransaction) {
            if (isSameDay(transaction.date, weekDay)) {
              totalSum += transaction.value;
            }
          }

          return {
            'day': DateFormat.E().format(weekDay)[0],
            'value': totalSum,
          };
        })
        .toList()
        .reversed
        .toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: tr['value'] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
