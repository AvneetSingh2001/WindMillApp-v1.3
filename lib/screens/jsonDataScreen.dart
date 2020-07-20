import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windmillApp/screens/farmDetails.dart';
import 'package:windmillApp/screens/predictionJSONloader.dart';
import 'dart:async';
import '../helpers/fetchedjsondata.dart';
import 'detailsJsonDataScreen.dart';
import 'dart:convert';

class JsonDataScreen extends StatefulWidget {
  final int i;
  final String path;
  final bool bothAreNotLoaded;
  JsonDataScreen(
    this.i,
    this.path,
    this.bothAreNotLoaded,
  );
  @override
  _JsonDataScreenState createState() => _JsonDataScreenState();
}

class _JsonDataScreenState extends State<JsonDataScreen> {
  final List<String> url = [
    "https://ibm-wind-api.herokuapp.com/data?file=Brahmanvel/Brahmanvel_Wind_48hrs",
    "https://ibm-wind-api.herokuapp.com/data?file=Dhalgaon/Dhalgaon_Wind_48hrs",
    "https://ibm-wind-api.herokuapp.com/data?file=Jaisalmer/Jaisalmer_Wind_48hrs",
    "https://ibm-wind-api.herokuapp.com/data?file=Muppandal/Muppandal_Wind_48hrs",
    "https://ibm-wind-api.herokuapp.com/data?file=Satara/Satara_Wind_48hrs",
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
        dateTime[i].add("$key");
        values[i].add("$value");
      });
    }

    setState(() {
      if (dateTime != null) {
        isLoaded = true;
        this.moveToGraphOutputs();
        // getColumnData();
      }
    });
  }

  moveToGraphOutputs() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (widget.path == "howCanWeHelpYou") {
            return FarmDetails(widget.i);
          } else if (widget.path == "selectTheWindFarm") {
            if (widget.bothAreNotLoaded == true) {
              return PredictionJSONloader(widget.i, "selectTheWindFarm");
            } else {
              return DetailsJsonDataScreen(widget.i, "selectTheWindFarm");
            }
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

class JsonData {
  String x;
  double y;

  JsonData(this.x, this.y);
}

dynamic getColumnData(int i) {
  List<JsonData> columnData = [];

  int len = dateTime[i].length;
  print(len);
  for (int j = 0; j < len; j++) {
    columnData.add(JsonData(
        "${dateTime[i][j].substring(0, 10)}\n${dateTime[i][j].substring(11)}",
        double.parse(values[i][j])));
  }

  return columnData;
}
