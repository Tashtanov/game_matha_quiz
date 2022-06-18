import 'package:flutter/material.dart';
import 'package:game_app/widgets/scorea_indicators.dart';
import 'package:game_app/quiz_game.dart';

QuizBrain _quizBrain = QuizBrain();

class GameScreen extends StatefulWidget {
  static final id = "game_screen";

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
  }

  void startGame() {
    _quizBrain.makeQuiz();
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
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          )),
          child: Column(
            children: [
              ScoreIndicators(),
              Expanded(
                  child: FittedBox(
                      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _quizBrain.quiz,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "Architects Daughter",
                    color: Colors.white
                  ),
                ),
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
