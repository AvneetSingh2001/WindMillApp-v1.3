import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windmillApp/screens/detailsJsonDataScreen.dart';
import 'package:windmillApp/screens/farmDetails.dart';
import 'dart:async';
import 'dart:convert';
import '../helpers/fetchedjsondata.dart';
import 'allgraphtableJSONScreen.dart';

class PredictionJSONloader extends StatefulWidget {
  final String requestFrom;
  final int val;
  PredictionJSONloader(
    this.val,
    this.requestFrom,
  );
  @override
  _PredictionJSONloaderState createState() => _PredictionJSONloaderState();
}

class _PredictionJSONloaderState extends State<PredictionJSONloader> {
  final List<String> url = [
    "https://ibm-wind-api.herokuapp.com/data?file=Brahmanvel/Brahmanvel_Predictions",
    "https://ibm-wind-api.herokuapp.com/data?file=Dhalgaon/Dhalgaon_Predictions",
    "https://ibm-wind-api.herokuapp.com/data?file=Jaisalmer/Jaisalmer_Predictions",
    "https://ibm-wind-api.herokuapp.com/data?file=Muppandal/Muppandal_Predictions",
    "https://ibm-wind-api.herokuapp.com/data?file=Satara/Satara_Predictions",
  ];

  int i = 0;

  @override
  void initState() {
    super.initState();
    this.getJSONdata();
  }

  Future getJSONdata() async {
    for (int i = 0; i < noOfFarms; i++) {
      var response = await http.get(
        Uri.encodeFull(url[i]),
      );
      var data = json.decode(response.body);
      data.forEach((key, value) {
        dateTimePrediction[i].add("$key");
        valuesPrediction[i].add("$value");
      });
    }

// FIXME:
    setState(() {
      if (dateTimePrediction != null) {
        isLoadedPrediction = true;
        this.moveToGraphOutputs();
        // getColumnData();
      }
    });
  }

//FIXME:
  moveToGraphOutputs() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (widget.requestFrom == "howCanWeHelpYou") {
            return AllGraphTableJSON();
          } else if (widget.requestFrom == "selectTheWindFarm") {
            return DetailsJsonDataScreen(widget.val, 'selectTheWindFarm');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PredictionJsonData {
  String x;
  double y;

  PredictionJsonData(this.x, this.y);
}

dynamic getPredictionColumnData(int i) {
  List<PredictionJsonData> columnData = [];

  int len = dateTimePrediction[i].length;
  print(len);
  for (int j = 0; j < len; j++) {
    columnData.add(PredictionJsonData(
        "${dateTimePrediction[i][j].substring(0, 10)}\n${dateTimePrediction[i][j].substring(11)}",
        double.parse(valuesPrediction[i][j])));
  }

  return columnData;
}
