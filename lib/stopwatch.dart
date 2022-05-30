import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Stopwatch extends StatefulWidget {
  final Function(bool) progressBarNotifier;

  const Stopwatch({Key? key, required this.progressBarNotifier})
      : super(key: key);

  @override
  State<Stopwatch> createState() => StopwatchState();
}

class StopwatchState extends State<Stopwatch> {
  late int seconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  void resetTimer() {
    seconds = 30;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      if (seconds != 0) {
        seconds--;
        widget.progressBarNotifier(false);
      } else {
        widget.progressBarNotifier(true);
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        const Icon(
          FontAwesomeIcons.stopwatch,
          color: Colors.white,
        ),
        Text('$seconds',
            style: width < 600
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
