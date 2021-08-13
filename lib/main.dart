import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

void main() {
  runApp(CountdownApp());
}

class CountdownApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CountdownAppState();
  }
}

class CountdownAppState extends State<CountdownApp> {
  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool active = false;

  Timer? timer;

  void handleTick() {
    if (active) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(fontFamily: GoogleFonts.openSans().fontFamily),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Timer'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextContainer(hours.toString().padLeft(2, '0'), 'Hrs',
                          [255, 80, 160, 255]),
                      TextContainer(minutes.toString().padLeft(2, '0'), 'Min',
                          [255, 80, 160, 255]),
                      TextContainer(seconds.toString().padLeft(2, '0'), 'Sec',
                          [255, 80, 160, 255])
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(active ? 'Stop' : 'Start'),
                          onPressed: () {
                            setState(() {
                              active = !active;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                              textStyle: TextStyle(
                                  fontSize: 20
                              )
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Reset'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              textStyle: TextStyle(
                                fontSize: 20
                              )
                          ),
                          onPressed: () {
                            setState(() {
                              // active = !active;
                              secondsPassed = 0;
                              if (timer == null) {
                                timer = Timer.periodic(duration, (Timer t) {
                                  handleTick();
                                });
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ),
                ]))));
  }
}

class TextContainer extends StatelessWidget {
  String value = "";
  String label = "";
  var colorArray = [0, 0, 0, 0];

  TextContainer(String value, String label, var colorArray) {
    this.value = value;
    this.label = label;
    this.colorArray = colorArray;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(
              colorArray[0], colorArray[1], colorArray[2], colorArray[3]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text('$value',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 54,
                  fontWeight: FontWeight.bold)),
          Text('$label',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
