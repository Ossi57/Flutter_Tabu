import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

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
