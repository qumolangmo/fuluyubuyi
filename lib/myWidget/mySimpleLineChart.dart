import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DeveloperSeries{
  final String x;
  final double y;
  final charts.Color barColor;

  DeveloperSeries({required this.x,required this.y,required this.barColor});
}

// ignore: must_be_immutable
class MySimpleLineChart extends StatefulWidget {

  late List<DeveloperSeries> data;
  MySimpleLineChart({super.key,required this.data});

  @override
  State<MySimpleLineChart> createState() => _MySimpleLineChartState();
}

class _MySimpleLineChartState extends State<MySimpleLineChart> {
  
  @override
  Widget build(BuildContext context) {
    List<charts.Series<DeveloperSeries,String>> Series = [
      charts.Series(
        id:"developers",
        data: widget.data,
        domainFn: (DeveloperSeries series, _)=>series.x,
        measureFn: (DeveloperSeries series, _)=>series.y,
        colorFn: (DeveloperSeries series, _)=>series.barColor
      )
    ];
    return charts.BarChart(Series, animate: true,);
  }
}