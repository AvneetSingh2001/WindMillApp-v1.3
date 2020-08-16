import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60.0),
                width: width,
                child: Text(
                  "About Us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Divider(
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(7.0),
                margin: EdgeInsets.only(top: 40.0),
                width: width,
                height: 220.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: Text("asdbiasuacq\nsdvwvwvwv\necvwvwvwvw"),
                      ),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg',
                          ),
                          maxRadius: 50.0,
                          minRadius: 40.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(7.0),
                margin: EdgeInsets.only(top: 20.0),
                width: width,
                height: 220.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: Text("asdbiasuacq\nsdvwvwvwv\necvwvwvwvw"),
                      ),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg',
                          ),
                          maxRadius: 50.0,
                          minRadius: 40.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
