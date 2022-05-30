import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "roboto"),
          headlineMedium: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "roboto"),
          headlineSmall: TextStyle(
              color: Colors.white,
              fontFamily: "bangla",
              fontSize: 15,
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 30, fontFamily: "bangla"),
          bodyMedium: TextStyle(
              fontSize: 30, color: Colors.white, fontFamily: "bangla"),
          bodySmall: TextStyle(
              fontSize: 23, color: Colors.white, fontFamily: "bangla"),
          displayLarge: TextStyle(
              fontSize: 30, color: Colors.black, fontFamily: "roboto"),
          displayMedium: TextStyle(
              fontSize: 20, color: Colors.black, fontFamily: "roboto"),
          displaySmall: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: "roboto"),
          labelLarge: TextStyle(
              fontSize: 30, color: Colors.white, fontFamily: "roboto"),
          labelMedium: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: "roboto",
              fontWeight: FontWeight.bold),
          labelSmall: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontFamily: "roboto",
              fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.teal,
            secondary: const Color.fromRGBO(7, 116, 104, 1),
            tertiary: const Color.fromRGBO(255, 193, 6, 1)),
      ),
      home: const Home(),
    );
  }
}
