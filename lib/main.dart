import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextAnimationControl(),
    );
  }
}

class TextAnimationControl extends StatefulWidget {
  @override
  _TextAnimationControlState createState() => _TextAnimationControlState();
}

class _TextAnimationControlState extends State<TextAnimationControl> {
  double _duration = 1.0; // Duration in seconds
  Curve _curve = Curves.easeIn;

  void _updateDuration(double newDuration) {
    setState(() {
      _duration = newDuration;
    });
  }

  void _updateCurve(Curve newCurve) {
    setState(() {
      _curve = newCurve;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adjustable Text Animation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            min: 0.5,
            max: 5.0,
            divisions: 9,
            label: "${_duration.toStringAsFixed(1)} s",
            value: _duration,
            onChanged: (double value) {
              _updateDuration(value);
            },
          ),
          DropdownButton<Curve>(
            value: _curve,
            onChanged: (Curve? newValue) {
              if (newValue != null) {
                _updateCurve(newValue);
              }
            },
            items: [
              DropdownMenuItem(child: Text("Ease In"), value: Curves.easeIn),
              DropdownMenuItem(child: Text("Ease Out"), value: Curves.easeOut),
              DropdownMenuItem(child: Text("Linear"), value: Curves.linear),
              DropdownMenuItem(child: Text("Bounce In"), value: Curves.bounceIn),
            ],
          ),
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: _duration.toInt()),
            curve: _curve,
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}