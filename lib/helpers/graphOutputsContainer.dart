import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../screens/predictionJSONloader.dart';
import '../screens/detailsJsonDataScreen.dart';

class GraphOutputsContainer extends StatefulWidget {
  final int i;
  final String farmName;
  GraphOutputsContainer(
    this.i,
    this.farmName,
  );
  @override
  _GraphOutputsContainerState createState() => _GraphOutputsContainerState();
}

class _GraphOutputsContainerState extends State<GraphOutputsContainer> {
  List<Color> colorPallete = [
    Colors.cyan,
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.yellow,
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          width: width,
          child: Text(
            "${widget.farmName}",
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 345,
          width: width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 7.0),
                child: SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(
                    duration: 5000.0,
                    enable: true,
                    elevation: 7.0,
                    borderWidth: 2,
                    // TODO:
                    format: 'point.y m/s\n Date - point.x : Time',
                  ),
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: "Date - Time",
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Power (per 100 units)',
                    ),
                  ),
                  series: <LineSeries<PredictionJsonData, String>>[
                    LineSeries<PredictionJsonData, String>(
                      name: "Power Output",
                      dataSource: getPredictionColumnData(widget.i),
                      xValueMapper: (PredictionJsonData data, _) => data.x,
                      yValueMapper: (PredictionJsonData data, _) => data.y,
                      color: colorPallete[widget.i],
                    ),
                  ],
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsJsonDataScreen(
                            widget.i,
                            'howCanWeHelpYou',
                          ),
                        ));
                  },
                  child: Text(
                    "Click here to expand",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
