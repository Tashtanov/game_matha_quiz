import 'dart:math';

class QuizBrain {
  var _quizanswer="";
  var _quiz="";
  void makeQuiz() {
    List<String> _listOfSign = ['-', "+", "⋅", "÷"];
    Random _random = Random();
    var selectedSign = _listOfSign[_random.nextInt(_listOfSign.length)];
    var firstNumber = _random.nextInt(10) + 10;
    var secondNumber = _random.nextInt(9) + 1;
    var realResult;

    switch (selectedSign) {
      case "+":
        realResult = firstNumber + secondNumber;
        break;
      case "-":
        realResult = firstNumber - secondNumber;
        break;
      case "⋅":
        realResult = firstNumber * secondNumber;
        break;
      case "÷":{
        if (firstNumber % secondNumber != 0) {
          if (firstNumber % 2 != 0) firstNumber++;
          for (int i = secondNumber; i > 0; i--) {
            if (firstNumber % i == 0) {
              secondNumber = i;
              break;
            }
          }
        }
        realResult=firstNumber~/secondNumber;
      }
    }

    var falsemaker=[-3,-2,-1,1,2,3];
    var randomlychosen=falsemaker[_random.nextInt(falsemaker.length)];

    var truefalsedecision=_random.nextInt(2);
    _quizanswer="TRUE";
    if(truefalsedecision==0){
      realResult=realResult+randomlychosen;
        _quizanswer="FALSE";
      if (realResult<0) {
        realResult=realResult=_random.nextInt(2)+4;
      }
    }
    _quiz="${firstNumber} ${selectedSign} ${secondNumber} = ${realResult}";
  }

  get quiz => _quiz;

  get quizanswer => _quizanswer;
}
