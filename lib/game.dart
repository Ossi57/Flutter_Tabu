import 'package:assignment2/classes/CardElementConfig.dart';
import 'package:assignment2/classes/TeamSetup.dart';
import 'package:assignment2/progressbar.dart';
import 'package:flutter/material.dart';

import 'classes/team.dart';
import 'enums/Player.dart';
import 'stopwatch.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game> {
  Player _currentPlayer = Player.PLAYER1;
  double _width = 0;
  double _height = 0;
  final GlobalKey<StopwatchState> _stopWatchKey = GlobalKey();
  final GlobalKey<ProgressBarState> _progressBarKey = GlobalKey();
  var _card = CardElementConfig.getRandomCard();
  bool _running = false;
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    if (_height < 400) {
      _disabled = true;
    } else {
      _disabled = false;
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            ProgressBar(key: _progressBarKey),
            const Divider(height: 20),
            team(),
            startButton(),
            gameHandler(),
          ],
        ),
        cardElement(),
      ],
    );
  }

  Widget startButton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () => {_running ? null : _startGame()},
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary)),
          child: Text(
            _getCurrentTeam().toString(),
            style: _width < 600
                ? Theme.of(context).textTheme.displaySmall
                : Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }

  Widget team() {
    double heightFactor = teamFactorCalculation();
    if (!_disabled) {
      return Column(
        children: <Widget>[
          Container(
            height: _height * heightFactor,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: <Widget>[
                _teamCard(Colors.green, Team.TEAM1.name),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stopwatch(
                    key: _stopWatchKey,
                    progressBarNotifier: _refreshProgressBar,
                  ),
                ),
                _teamCard(Colors.red, Team.TEAM2.name),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget gameHandler() {
    return SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _createButton("TABU", Colors.red, 2),
            const SizedBox(width: 5),
            _createButton("PASS", const Color.fromRGBO(63, 81, 181, 1), 2),
            const SizedBox(width: 5),
            _createButton("TRUE", Colors.green, 2),
          ],
        ),
      ),
    );
  }

  Widget cardElement() {
    double heightFactor = cardElementFactorCalculation();
    if (!_disabled) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: _width * 0.6,
            decoration: BoxDecoration(
              color: (_currentPlayer == Player.PLAYER1
                  ? Colors.green
                  : Colors.red),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Center(
                child: Text(
              _card!.name,
              style: _width < 600
                  ? Theme.of(context).textTheme.headlineMedium
                  : Theme.of(context).textTheme.headlineLarge,
            )),
          ),
          Container(
            height: _height * heightFactor,
            width: _width * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Center(
                child: Column(
              children: [
                for (var desc in _card!.disallowed)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(desc.toUpperCase(),
                            style: _width < 600
                                ? Theme.of(context).textTheme.displayMedium
                                : Theme.of(context).textTheme.displayLarge),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6 * 0.5,
                          child: const Divider())
                    ],
                  )
              ],
            )),
          ),
        ],
      );
    } else {
      return const Text("View not supported!");
    }
  }

  //helper widgets

  Widget _teamCard(Color color, String teamName) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _height * 0.1 * 0.6,
            width: _width * 0.17,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Center(
                child: Text(
              teamName == Team.TEAM1.name
                  ? TeamSetup.team1.toString()
                  : TeamSetup.team2.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: (_width < 600) ? 25 : 40),
            )),
          ),
          Container(
            height: _height * 0.1 * 0.2,
            width: _width * 0.17,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                teamName,
                style: _width < 600
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButton(String text, Color color, int flex) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: () => {!_running ? null : _determineButton(text)},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            backgroundColor: MaterialStateProperty.all(color)),
        child: Text(
          text,
          style: _width < 600
              ? Theme.of(context).textTheme.bodySmall
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  //game logic
  void _refreshProgressBar(bool isReset) {
    if (!isReset) {
      _progressBarKey.currentState!.startProgressBar();
    } else {
      _nextTurn();
    }
  }

  void _tabu() {
    setState(() {
      TeamSetup.teamPointsChanged(-1, _currentPlayer);
      getNewCard();
    });
  }

  void _pass() {
    getNewCard();
  }

  void _right() {
    setState(() {
      TeamSetup.teamPointsChanged(1, _currentPlayer);
      getNewCard();
    });
  }

  void getNewCard() {
    setState(() {
      _card = CardElementConfig.getRandomCard();
    });
  }

  void _switchPlayer() {
    if (_currentPlayer == Player.PLAYER1) {
      _currentPlayer = Player.PLAYER2;
    } else {
      _currentPlayer = Player.PLAYER1;
    }
  }

  String _getCurrentTeam() {
    if (_currentPlayer == Player.PLAYER1) {
      return "${Team.TEAM1.name}-START";
    } else {
      return "${Team.TEAM2.name}-START";
    }
  }

  void _determineButton(String text) {
    if (text == "TABU") {
      _tabu();
    } else if (text == "PASS") {
      _pass();
    } else if (text == "TRUE") {
      _right();
    }
  }

  void _startGame() {
    if (!_running) {
      _stopWatchKey.currentState!.startTimer();
      _running = true;
    }
  }

  void _nextTurn() {
    setState(() {
      _card = CardElementConfig.getRandomCard();
      _stopWatchKey.currentState!.resetTimer();
      _progressBarKey.currentState!.resetProgressBar();
      _switchPlayer();
      _running = false;
    });
  }

  //calculations
  double cardElementFactorCalculation() {
    double heightFactor = 0.5;
    if (_height > 800 && _height < 1200) {
      heightFactor = 0.35;
    } else if (_height > 1200) {
      heightFactor = 0.25;
    } else if (_height > 400 && _height < 800) {
      heightFactor = 0.07;
    }
    return heightFactor;
  }

  double teamFactorCalculation() {
    double heightFactor = 0.1;
    if (_height > 800) {
      heightFactor = 0.1;
    } else if (_height > 400 && _height < 800) {
      heightFactor = 0.2;
    } else {
      heightFactor = 0.3;
    }
    return heightFactor;
  }
}
