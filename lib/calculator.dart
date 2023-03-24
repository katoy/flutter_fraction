// lib/calculator.dart
import 'package:fraction/fraction.dart';
import 'number_converter.dart';

class Calculator {
  static Fraction calculate(String number1, String number2, String operation) {
    Fraction result = Fraction(0, 1);
    switch (operation) {
      case "+":
        result = add(number1, number2);
        break;
      case "-":
        result = subtract(number1, number2);
        break;
      case "*":
        result = multiply(number1, number2);
        break;
      case "/":
        result = divide(number1, number2);
        break;
    }
    return result.reduce();
  }

  static Fraction add(String a, String b) {
    Fraction fractionA = NumberConverter.toFraction(a);
    Fraction fractionB = NumberConverter.toFraction(b);
    Fraction resultFraction = fractionA + fractionB;

    return resultFraction;
  }

  static Fraction subtract(String a, String b) {
    Fraction fractionA = NumberConverter.toFraction(a);
    Fraction fractionB = NumberConverter.toFraction(b);
    Fraction resultFraction = fractionA - fractionB;

    return resultFraction;
  }

  static Fraction multiply(String a, String b) {
    Fraction fractionA = NumberConverter.toFraction(a);
    Fraction fractionB = NumberConverter.toFraction(b);
    Fraction resultFraction = fractionA * fractionB;

    return resultFraction;
  }

  static Fraction divide(String a, String b) {
    Fraction fractionA = NumberConverter.toFraction(a);
    Fraction fractionB = NumberConverter.toFraction(b);
    Fraction resultFraction = fractionA / fractionB;

    return resultFraction;
  }
}
