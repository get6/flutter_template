import 'package:flutter/material.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              child: Text("Copy"),
              value: "copy",
            ),
            PopupMenuItem(
              child: Text("Cut"),
              value: "cut",
            ),
            PopupMenuItem(
              child: Text("paste"),
              value: "paste",
            ),
          ],
        )),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _color = Colors.yellow;
  var _height = 200.0;
  var _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          color: _color,
          width: _width,
          height: _height,
        ),
        RaisedButton(
          child: Text("Animate!"),
          onPressed: () {
            setState(() {
              _color = Colors.red;
              _height = 400.0;
              _width = 400.0;
            });
          },
        )
      ],
    );
  }
}

class AniCF extends StatefulWidget {
  @override
  _AniCFState createState() => _AniCFState();
}

class _AniCFState extends State<AniCF> {
  var _showFirst = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 100.0,
            ),
            FlutterLogo(
              style: FlutterLogoStyle.stacked,
              size: 100.0,
            ),
            FlutterLogo(
              style: FlutterLogoStyle.markOnly,
              size: 100.0,
            )
          ],
        ),
        Divider(),
        AnimatedCrossFade(
          firstChild: FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100.0,
          ),
          secondChild: FlutterLogo(
            style: FlutterLogoStyle.stacked,
            size: 100.0,
          ),
          crossFadeState:
              _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(seconds: 2),
        ),
        RaisedButton(
          child: Text("Cross-Fade"),
          onPressed: () {
            _showFirst = false;
            setState(() {});
          },
        )
      ],
    );
  }
}

class AniDTS extends StatefulWidget {
  @override
  _AniDTSState createState() => _AniDTSState();
}

class _AniDTSState extends State<AniDTS> {
  var _color = Colors.red;
  var _fontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDefaultTextStyle(
          child: Text("I am some text"),
          style: TextStyle(color: _color, fontSize: _fontSize),
          duration: const Duration(seconds: 1),
        ),
        RaisedButton(
          child: Text("Enhance! Enhance! Enhace!"),
          onPressed: () {
            _color = Colors.blue;
            _fontSize = 40.0;
            setState(() {});
          },
        )
      ],
    );
  }
}
