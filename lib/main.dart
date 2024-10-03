import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiFeatureApp(),
    );
  }
}

class MultiFeatureApp extends StatefulWidget {
  @override
  _MultiFeatureAppState createState() => _MultiFeatureAppState();
}

class _MultiFeatureAppState extends State<MultiFeatureApp>
    with SingleTickerProviderStateMixin {
  double _duration = 1.0; // Duration in seconds
  Curve _curve = Curves.easeIn;
  bool _isImageRounded = false;
  bool _isImageFaded = true;
  AnimationController? _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController?.dispose();
    super.dispose();
  }

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

  void toggleImageRotation() {
    if (_rotationController!.isAnimating) {
      _rotationController!.stop();
    } else {
      _rotationController!.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Animation Features'),
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
              DropdownMenuItem(
                  child: Text("Bounce In"), value: Curves.bounceIn),
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
          SwitchListTile(
            title: Text("Toggle Rounded Corners on Image"),
            value: _isImageRounded,
            onChanged: (bool value) {
              setState(() {
                _isImageRounded = value;
              });
            },
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placekitten.com/200/300"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(_isImageRounded ? 30.0 : 0.0),
            ),
          ),
          SwitchListTile(
            title: Text("Toggle Image Fade"),
            value: _isImageFaded,
            onChanged: (bool value) {
              setState(() {
                _isImageFaded = value;
              });
            },
          ),
          AnimatedOpacity(
            opacity: _isImageFaded ? 1.0 : 0.0,
            duration: Duration(seconds: 2),
            child: Image.network("https://placekitten.com/200/300"),
          ),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController!),
            child: Image.network("https://placekitten.com/200/300"),
          ),
          FloatingActionButton(
            onPressed: toggleImageRotation,
            child: Icon(_rotationController!.isAnimating
                ? Icons.stop
                : Icons.rotate_right),
          ),
        ],
      ),
    );
  }
}
