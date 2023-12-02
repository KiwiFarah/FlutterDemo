import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  late Timer timer;
  bool doneTimer = false;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }
  void startTimer() {
    setState(() {
      isActive = true;
    });
    timer?.cancel(); // Cancel existing timer
    timer = Timer.periodic(duration, (Timer t) {
      handleTick();
    });
  }

  void pauseTimer() {
    setState(() {
      isActive = false;
    });
  }

  void resetTimer() {
    setState(() {
      secondsPassed = 0;
      isActive = false;
    });
    timer?.cancel();
  }



  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'Hours', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'Minutes', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'Seconds', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text('Start'),
                      onPressed: startTimer,
                    ),
                    ElevatedButton(
                      child: Text('Pause'),
                      onPressed: pauseTimer,
                    ),
                    ElevatedButton(
                      child: Text('Reset'),
                      onPressed: resetTimer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

