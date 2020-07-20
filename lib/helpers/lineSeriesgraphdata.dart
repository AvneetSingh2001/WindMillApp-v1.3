import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import '../screens/predictionJSONloader.dart';

lineSeries(String name, int i) {
  List<Color> colorPallete = [
    Colors.cyan,
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.yellow,
  ];
  return LineSeries<PredictionJsonData, String>(
    name: "$name",
    dataSource: getPredictionColumnData(i),
    xValueMapper: (PredictionJsonData data, _) => data.x,
    yValueMapper: (PredictionJsonData data, _) => data.y,
    color: colorPallete[i],
  );
}
