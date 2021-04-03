import 'dart:math';

class Calculator {
  final int height;
  final int weight;
  double _bmi = 0.0;

  Calculator({required this.height, required this.weight});

  String calculate() {
    _bmi = weight / (pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return "Overweight";
    } else if (_bmi >= 18.5) {
      return "Normal";
    } else {
      return "Underweight";
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return "You have a higher than normal bodyweight.";
    } else if (_bmi >= 18.5) {
      return "You have a normal bodyweight. Good job!";
    } else {
      return "You have a lower than normal bodyweight. Try to eat more.";
    }
  }
}
