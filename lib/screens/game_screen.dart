import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/quiz_game.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

QuizBrain _quizBrain = QuizBrain();
int _score = 0;
int _highScore = 0;
double _value = 0;
int _falseCounter = 0;
int _totalQuizCount=0;

class GameScreen extends StatefulWidget {
  static final id = "game_screen";

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Timer _timer;
  int _totalTimer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
  }

  void startGame() {
    _quizBrain.makeQuiz();
    startTimer();
    _value = 1;
    _score = 0;
    _falseCounter = 0;
    _totalQuizCount=1;
  }

  void startTimer() {
    const speed = Duration(milliseconds: 100);
    _timer = Timer.periodic(speed, (timer) {
      if (_value > 0) {
        setState(() {
          _value > 0.01 ? _value -= 0.01 : _value = 0;
          _totalTimer = (_value * 10 + 1).toInt();
        });
      } else {
        setState(() {
          if (_highScore < _score) {
            _highScore = _score;
          }
          _timer.cancel();
          _totalTimer = 0;
          showMyDialog();
        });
      }
    });
  }

  Future<void> showMyDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.lightGreen,
            title: FittedBox(
              child: const Text(
                "GAME OVER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Press Start 2P",
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            content: Text(
              "SCORE   ${_score} | ${_totalQuizCount}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    "Exit".toUpperCase(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    startGame();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Play Again".toUpperCase(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: kGradientcolor,
          )),
          child: Column(
            children: [
              ScoreIndicators(),
              GameBody(),
              buildCircularIndicator(totalTimer: _totalTimer),
              Expanded(
                child: Row(
                  children: [
                    ReUsableOutLinedButton(
                      textName: "FALSE",
                      colorName: Colors.redAccent,
                    ),
                    ReUsableOutLinedButton(
                      textName: "TRUE",
                      colorName: Colors.lightGreenAccent,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class buildCircularIndicator extends StatelessWidget {
  const buildCircularIndicator({
    Key? key,
    required int totalTimer,
  })  : _totalTimer = totalTimer,
        super(key: key);

  final int _totalTimer;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100,
      lineWidth: 15,
      percent: _value,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: _value > 0.6
          ? Colors.green
          : _value > 0.3
              ? Colors.yellow
              : Colors.red,
      center: Text(
        "${_totalTimer}",
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ReUsableOutLinedButton extends StatelessWidget {
  final textName;
  final colorName;

  ReUsableOutLinedButton({
    required this.textName,
    required this.colorName,
  });

  void checkAnswer() {
    if (textName == _quizBrain.quizanswer) {
      _score++;
      _value >= 0.89 ? _value = 1 : _value += 0.1;
    } else {
      _falseCounter++;
      _value < 0.1 * _falseCounter ? _value = 0 : _value -= 0.1 * _falseCounter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlineGradientButton(
            padding: EdgeInsets.all(25),
            elevation: 1,
            child: Center(
                child: FittedBox(
              child: Text(
                textName,
                style: kTextButtonStyleTrueFalse.copyWith(color: colorName),
              ),
            )),
            strokeWidth: 12,
            radius: Radius.circular(40),
            onTap: () {
              _totalQuizCount++;
              checkAnswer();
              _quizBrain.makeQuiz();

            },
            gradient: LinearGradient(colors: kGradientcolor)),
      ),
    );
  }
}

class GameBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FittedBox(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        _quizBrain.quiz,
        style: kQuizTextbody,
      ),
    )));
  }
}

class ScoreIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text("HIGHSCORE", style: kScoreTextIndicator),
              SizedBox(height: 10),
              Text(
                "$_highScore",
                style: kScoreIndicator,
              ),
            ],
          ),
          Column(
            children: [
              Text("SCORE", style: kScoreTextIndicator),
              SizedBox(height: 10),
              Text(
                "$_score",
                style: kScoreIndicator,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
