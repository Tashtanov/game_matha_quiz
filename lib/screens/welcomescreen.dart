import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/screens/game_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static final id = "welcome_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover)),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: AbsorbPointer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      "Math Quiz\n Game ",
                      textAlign: TextAlign.center,
                      textStyle: kAnimationTextStyle,
                      colors: kColorizeAnimationColors,
                    ),
                  ],
                  repeatForever: true,
                ),
                const Text(
                  "Tap to Start",
                  style: kTapToStartTextStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, GameScreen.id);
          },
        ),
      ),
    );
  }
}
