import 'package:flutter/material.dart';
import 'package:windmillApp/screens/aboutUsScreen.dart';
import 'package:windmillApp/screens/allgraphtableJSONScreen.dart';
import 'package:windmillApp/screens/predictionJSONloader.dart';
import 'package:windmillApp/screens/signIn.dart';
import 'package:windmillApp/screens/whyWeCreatedThisApp.dart';
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
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          drawer: Theme(
            data: ThemeData.light(),
            child: Drawer(
              child: ListView(
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text(
                      "Why we created this App?",
                      style: TextStyle(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WhyWeCreatedThisApp(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "About the Team",
                      style: TextStyle(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: height / 4.5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20.0)),
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
                    Padding(padding: EdgeInsets.only(top: 20.0)),
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
                    Padding(padding: EdgeInsets.only(top: 20.0)),
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
                    Padding(padding: EdgeInsets.only(top: 20.0)),
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
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Container(
                      alignment: Alignment.centerRight,
                      width: width,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          this._auth.signOut();
                        },
                        child: Text("Sign Out"),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
