import 'package:flutter/material.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/widgets/scorea_indicators.dart';
import 'package:game_app/quiz_game.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

QuizBrain _quizBrain = QuizBrain();
 int _score = 0;
 int _highScore = 0;
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
            colors: kGradientcolor,
          )),
          child: Column(
            children: [
              ScoreIndicators(),
              GameBody(),
              Row(
                children: [
                  ReUsableOutLinedButton(textName: "FALSE",colorName: Colors.redAccent,),
                  ReUsableOutLinedButton(textName: "TRUE",colorName: Colors.lightGreenAccent,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReUsableOutLinedButton extends StatelessWidget {
  final String textName;
  final Color colorName;
  const ReUsableOutLinedButton({
    Key? key, required this.textName,required this.colorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlineGradientButton(
          padding: EdgeInsets.all(20),
            elevation: 1,
            child: Center(
                child: Text(
              textName,
              style: kTextButtonStyleTrueFalse.copyWith(color: colorName),
            )),
            strokeWidth: 12,
            radius: Radius.circular(40),
            onTap: () {},
            gradient: LinearGradient(
                colors:kGradientcolor)),
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
