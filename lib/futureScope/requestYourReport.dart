import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmillApp/screens/signIn.dart';
import '../helpers/curvePainter.dart';
import 'formSubmittedScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'formData.dart';

class RequestYourReportScreen extends StatefulWidget {
  @override
  _RequestYourReportScreenState createState() =>
      _RequestYourReportScreenState();
}

class _RequestYourReportScreenState extends State<RequestYourReportScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  String email, state, city, numberOfWindmills, radius, powerCoefficient;
  bool isValidated;
  final databaseReference = FirebaseDatabase.instance.reference();
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

  uploadData() async {
    print(user.email);
    FormData data = FormData(this.email, this.state, this.city,
        this.numberOfWindmills, this.radius, this.powerCoefficient);
    await databaseReference.child("${user.uid}").set(data.toJson());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FormSubmittedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        // Backgeound Design
        CustomPaint(
          painter: CurvePainter(),
          size: Size.infinite,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _key,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: height / 5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Request Your Report",
                        style: TextStyle(
                          color: Colors.cyan[200],
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Icon(
                          Icons.mail,
                          size: 26.0,
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter email";
                          }
                        },
                        onSaved: (input) => email = input,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Icon(
                          Icons.place,
                          size: 26.0,
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter state";
                          }
                        },
                        onSaved: (input) => state = input,
                        decoration: InputDecoration(
                          labelText: "State",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Icon(
                          Icons.location_city,
                          size: 26.0,
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter city";
                          }
                        },
                        onSaved: (input) => city = input,
                        decoration: InputDecoration(
                          labelText: "City",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "✢",
                          style: TextStyle(
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "This field can't be empty";
                          }
                        },
                        onSaved: (input) => numberOfWindmills = input,
                        decoration: InputDecoration(
                          labelText: "No. of Windmills",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          "⟼",
                          style: TextStyle(
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter radius";
                          }
                        },
                        onSaved: (input) => radius = input,
                        decoration: InputDecoration(
                          labelText: "Radius",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          "η",
                          style: TextStyle(
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                      title: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter power coefficient";
                          }
                        },
                        onSaved: (input) => powerCoefficient = input,
                        decoration: InputDecoration(
                          labelText: "Power Coefficient",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                      color: Colors.cyan,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        _validate();
                        if (isValidated = true) {
                          uploadData();
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _validate() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      isValidated = true;
      print('hihiiiiiiiiiiiiiiiiiii');
    } else {
      isValidated = false;
    }
  }
}
