import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskStatisticsChart extends StatelessWidget {
  final Map<String, bool> statistics;
  final double containerHeight;

  TaskStatisticsChart({required this.statistics, required this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            // getDrawingHorizontalLine: (value) {
            //   return FlLine(color: Colors.black, strokeWidth: 1);
            // },
            getDrawingVerticalLine: (value) {
              return FlLine(color: Colors.black, strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _generateSpots(statistics),
              isCurved: true,
              // colors: [Colors.blue],
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: 0,
          maxX: statistics.length.toDouble() - 1,
          minY: _calculateMinY(statistics),
          maxY: _calculateMaxY(statistics),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots(Map<String, bool> statistics) {
    List<FlSpot> spots = [];
    int currentHeight = 0;

    for (int i = 0; i < statistics.length; i++) {
      bool value = statistics.values.elementAt(i);

      if (value) {
        currentHeight++;
      }

      spots.add(FlSpot(i.toDouble(), currentHeight.toDouble()));
    }

    return spots;
  }

  double _calculateMinY(Map<String, bool> statistics) {
    double minY = 0;
    if (statistics.isNotEmpty) {
      minY = statistics.values.first ? -1 : 0;
    }
    return minY;
  }

  double _calculateMaxY(Map<String, bool> statistics) {
    double maxY = 0;
    int trueCount = statistics.values.where((value) => value).length;
    maxY = trueCount.toDouble();
    return maxY;
  }
}
