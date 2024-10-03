import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageRoundedCorners(),
    );
  }
}

class ImageRoundedCorners extends StatefulWidget {
  @override
  _ImageRoundedCornersState createState() => _ImageRoundedCornersState();
}

class _ImageRoundedCornersState extends State<ImageRoundedCorners> {
  bool _isImageRounded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rounded Corners Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}