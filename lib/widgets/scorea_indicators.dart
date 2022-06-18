import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app/common/constants.dart';
class ScoreIndicators extends StatelessWidget {
  const ScoreIndicators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column( children: const [
              Text("HIGHSCORE",style:kScoreTextIndicator),
              SizedBox( height:10),
              Text("0",style: kScoreIndicator,),

            ],),
            Column( children: [
              Text("SCORE",style: kScoreTextIndicator,),
              SizedBox( height:10),
              Text("0",style: kScoreIndicator,),

            ],)
          ],
        ),
      ),
    );
  }
}
