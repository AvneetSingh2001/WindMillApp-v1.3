import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windmillApp/screens/jsonDataScreen.dart';
import 'dart:async';
import 'dart:convert';
import 'farmDetails.dart';
import '../helpers/fetchedjsondata.dart';

class DetailsJsonDataScreen extends StatefulWidget {
  final int i;
  final String path;
  DetailsJsonDataScreen(
    this.i,
    this.path,
  );
  @override
  _DetailsJsonDataScreenState createState() => _DetailsJsonDataScreenState();
}

class _DetailsJsonDataScreenState extends State<DetailsJsonDataScreen> {
  final List<String> url = [
    "https://ibm-wind-api.herokuapp.com/data?file=Brahmanvel/Brahmanvel_Features_2_days",
    "https://ibm-wind-api.herokuapp.com/data?file=Dhalgaon/Dhalgaon_Features_2_days",
    "https://ibm-wind-api.herokuapp.com/data?file=Jaisalmer/Jaisalmer_Features_2_days",
    "https://ibm-wind-api.herokuapp.com/data?file=Muppandal/Muppandal_Features_2_days",
    "https://ibm-wind-api.herokuapp.com/data?file=Satara/Satara_Features_2_days",
  ];

  @override
  void initState() {
    super.initState();
    this.getJSONdata();
  }

  Future getJSONdata() async {
    var response = await http.get(
      Uri.encodeFull(url[widget.i]),
    );
    var data = json.decode(response.body);
    if (key.isNotEmpty) {
      key.removeRange(0, 16);
      value.removeRange(0, 16);
    }
    data.forEach((k, v) {
      key.add("$k");
      value.add("$v");
    });
    this.dataFormatter();
    this.moveToNextScreen();
  }

  var keyLen;
  var valLen;
  dataFormatter() {
    for (int i = 0; i < key.length; i++) {
      keyLen = key[i].length;
      if (keyLen > 5) {
        key[i] = key[i].substring(0, 6);
      }
      valLen = value[i].length;
      if (valLen > 5) {
        value[i] = value[i].substring(0, 6);
      }
    }
  }

  moveToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (widget.path == "howCanWeHelpYou") {
            if (dateTime[0].length == 0) {
              return JsonDataScreen(widget.i, "howCanWeHelpYou", true);
            } else {
              return FarmDetails(widget.i);
            }
          } else if (widget.path == "selectTheWindFarm") {
            return FarmDetails(widget.i);
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
