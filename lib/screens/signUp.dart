import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:windmillApp/helpers/curvePainter.dart';
import 'package:windmillApp/screens/howCanWeHelpYou.dart';
import 'package:windmillApp/screens/signIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _password = "", _name = "";
  bool empty = true;
  int userLen = 0, passLen = 0, nameLen;
  bool isLoading = false, isValidated;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  isEmailVerified() async {
    _user.reload();
    FirebaseUser user = await _auth.currentUser();
    print(user.isEmailVerified);
    if (user.isEmailVerified == true) {
      showToast();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HowCanWeHelpYou(),
        ),
      );
    } else {
      showNotVerifyMessage();
    }
  }

  showToast() {
    Fluttertoast.showToast(
        msg: "$_email signed in successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  createUser() async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      _user = result.user;
      if (_user != null) {
        UserUpdateInfo updateUser = UserUpdateInfo();
        updateUser.displayName = _name;

        _user.updateProfile(updateUser);
      }
      sendMailVerification();
    } catch (e) {
      showError(e.message);
    }
    setState(() {
      isLoading = false;
    });
  }

  sendMailVerification() async {
    try {
      _user.sendEmailVerification();
      showVerifyMessage();
    } catch (e) {
      showError(e.message);
    }
  }

  showNotVerifyMessage() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ),
          );
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            "Email not verified",
            style: TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Try again, we have send you a verification email on $_email, Click verify when done",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                isEmailVerified();
              },
              child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }

  showVerifyMessage() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          isEmailVerified();
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            "Verify your Email",
            style: TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "We have send you a verification email on $_email, Click verify when done",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                isEmailVerified();
              },
              child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }

  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          "Error",
          style: TextStyle(
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  loginArrowColorChanger() {
    if (this.userLen != 0 && this.passLen != 0 && this.nameLen != 0) {
      setState(() {
        this.empty = false;
      });
    } else {
      setState(() {
        this.empty = true;
      });
    }
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
          // Main Screen Layout
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height / 7),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      // LOGIN ICONBUTTON
                      child: isLoading
                          ? Container(
                              height: 70.0,
                              width: 70.0,
                              child: CupertinoActivityIndicator(
                                radius: 20.0,
                              ),
                            )
                          : GestureDetector(
                              child: Icon(
                                Icons.arrow_forward,
                                size: 70.0,
                                color: empty ? Colors.white : Colors.cyan,
                              ),
                              onTap: () {
                                validator();
                                if (isValidated) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  createUser();
                                }
                              },
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.cyan[200],
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty == true) {
                            return "Enter name";
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            this.nameLen = val.length;
                            loginArrowColorChanger();
                          });
                        },
                        onSaved: (val) {
                          val = val.trimRight();
                          _name = val;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.cyan[200],
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: "NAME",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: "Enter your name",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 23.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty == true) {
                            return "Enter email";
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            this.userLen = val.length;
                            loginArrowColorChanger();
                          });
                        },
                        onSaved: (val) {
                          val = val.trimRight();
                          _email = val;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.cyan[200],
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: "EMAIL",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 23.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty == true) {
                            return "Enter password";
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            this.passLen = val.length;
                            loginArrowColorChanger();
                          });
                        },
                        onSaved: (val) {
                          _password = val;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.cyan[200],
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: "Enter password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 23.0,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 80.0, 5.0, 0.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ALREADY A MEMBER?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        color: Colors.cyan[200],
                        //TODO: ONPRESSED MOVE TO NEXT PAGE
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                        child: Text(
                          "CLICK HERE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  validator() {
    if (_formKey.currentState.validate()) {
      // saves to global key
      _formKey.currentState.save();
      isValidated = true;
    } else {
      isValidated = false;
    }
  }
}
