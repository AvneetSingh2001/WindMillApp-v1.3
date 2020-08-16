import 'package:flutter/material.dart';

class WhyWeCreatedThisApp extends StatefulWidget {
  @override
  _WhyWeCreatedThisAppState createState() => _WhyWeCreatedThisAppState();
}

class _WhyWeCreatedThisAppState extends State<WhyWeCreatedThisApp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text(
                "Why we created this app",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Container(
              child: Text(
                "cwncbkwhc khwev hcv wkcv wvc ugvwuk vwvcwyhq lcfywlyv efUTVWYGEyfvlWG  UE;QNF ugwl yGNLW YEGF BNge yBGWEYL B",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
