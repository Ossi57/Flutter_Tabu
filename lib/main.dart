import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:RoundedProgressBar(
        style: RoundedProgressBarStyle(
          borderWidth: 0, 
          widthShadow: 0
        ),
        margin: EdgeInsets.symmetric(
          vertical: 16
        ),
        borderRadius: BorderRadius.circular(24),
        percent: percent,
      ),
    );
  }
}
