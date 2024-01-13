import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_ai_test/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class WelcomeGradientBackground extends StatefulWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  const WelcomeGradientBackground({Key? key, this.child, this.padding, this.decoration}) : super(key: key);

  @override
  WelcomeGradientBackgroundState createState() => WelcomeGradientBackgroundState();
}

class WelcomeGradientBackgroundState extends State<WelcomeGradientBackground> {
  List _colors = [
    // const Color(0xFFE0F2F1),
    // const Color(0xFF00E676),
    // Colors.green,
    // const Color(0xCCEFFFCC),
    // const Color(0xFFEFBBBB),
    // const Color(0xFFEFFFFC),
    // const Color(0xFFEFCCBC),
    // const Color(0xFFE0F2F1),
    // const Color(0xFFEECDA3),
    // const Color(0xFFEF629F),

    const Color.fromARGB(255, 245, 242, 238),
    const Color(0xFFEFCCBC),
    Colors.orangeAccent,
  ];

  int _currentColorIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start the timer
  void _startTimer() {
    // Set up a periodic timer that triggers the color change every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  // Cancel the timer when the widget is disposed
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _colors = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? [
            Theme.of(context).cardColor,
            Colors.black87,
            Colors.grey[900],
          ]
        : [
            // const Color(0xFFF9FBE7),
            // const Color(0xFFF0F4C3),
            // const Color(0xFFE0F2F1),
            // const Color(0xFFC8E6C9),
            // const Color(0xFF4CAF50),
            // const Color(0xFF00E676),

            Color.fromARGB(255, 245, 242, 238),
            const Color(0xFFEFCCBC),
            // const Color(0xFFEECDA3),
          ];
    return widget.child != null
        ? AnimatedContainer(
            padding: widget.padding,
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
              gradient: LinearGradient(
                colors: [
                  _colors[_currentColorIndex], // Use the current color
                  _colors[(_currentColorIndex + 1) % _colors.length], // Use the next color in the list
                  _colors[(_currentColorIndex + 1) % _colors.length], // Use the next color in the list
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: widget.child,
          )
        : AnimatedContainer(
            height: 200,
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _colors[_currentColorIndex], // Use the current color
                  _colors[(_currentColorIndex + 1) % _colors.length], // Use the next color in the list
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
  }
}
