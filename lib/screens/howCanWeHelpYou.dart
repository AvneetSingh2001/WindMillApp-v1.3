import 'package:flutter/material.dart';
import 'package:windmillApp/screens/allgraphtableJSONScreen.dart';
import 'package:windmillApp/screens/predictionJSONloader.dart';
import 'package:windmillApp/screens/signIn.dart';
import '../helpers/curvePainter.dart';
import '../helpers/colorGradient.dart';
import 'selectFarm.dart';
import '../futureScope/requestYourReport.dart';
import '../helpers/fetchedjsondata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HowCanWeHelpYou extends StatefulWidget {
  @override
  _HowCanWeHelpYouState createState() => _HowCanWeHelpYouState();
}

class _HowCanWeHelpYouState extends State<HowCanWeHelpYou> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    getUser();
    checkAuthentication();
  }

  getUser() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if (user == null || user.isEmailVerified == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: CurvePainter(),
          size: Size.infinite,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: height / 4.8),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "How can we help you ?",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 60.0)),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectFarm(),
                            ),
                          );
                        },
                        child: Text(
                          "Power forecast\n(Location Wise)",
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
                        ),
                        color: Colors.cyan[300],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          if (isLoadedPrediction) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllGraphTableJSON(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    //FIXME: 0 passed just because it is neccessary
                                    PredictionJSONloader(0, 'howCanWeHelpYou'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Optimum output",
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
                        ),
                        color: Colors.cyan[300],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.all(20.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestYourReportScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Power Forecasts for Your Own Farm",
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.cyan[300],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.cyan[300],
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _auth.signOut();
            },
          ),
        ),
      ],
    );
  }
}
