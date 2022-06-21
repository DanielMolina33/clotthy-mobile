import 'package:flutter/material.dart';
import 'line_chart_widget.dart';

class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        height: 450,
        width: 250,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LineChartWidget(),
          ),
        ),
      );
}
