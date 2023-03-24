// lib/number_converter.dart
import 'dart:math' as math;

import 'package:fraction/fraction.dart';

class NumberConverter {
  // Convert a Fraction object to a string representation
  static String fractionToString(Fraction fraction) {
    return '${fraction.numerator}/${fraction.denominator}';
  }

  // Convert an input string to a Fraction object
  static Fraction toFraction(String input) {
    if (input.contains('/')) {
      // If the input is a fraction
      List<String> parts = input.split('/');
      int numerator = int.parse(parts[0]);
      int denominator = int.parse(parts[1]);
      return Fraction(numerator, denominator);
    } else if (input.contains('(')) {
      // If the input is a recurring decimal
      return fromRecurringDecimal(input);
    } else if (input.contains('.')) {
      // If the input is a decimal
      return Fraction.fromString(input);
    } else {
      // If the input is a decimal
      return Fraction.fromString(input);
    }
  }

  static Fraction fromRecurringDecimal(String recurringDecimal) {
    // Remove the integer part
    int decimalPointIndex = recurringDecimal.indexOf('.');
    String integerPart = recurringDecimal.substring(0, decimalPointIndex);
    String decimalPart = recurringDecimal.substring(decimalPointIndex + 1);

    // Check for the recurring pattern
    RegExp pattern = RegExp(r'\((\d+)\)');
    Match? match = pattern.firstMatch(decimalPart);

    if (match != null) {
      // Extract the non-repeating and repeating parts
      String nonRepeatingPart = decimalPart.substring(0, match.start);
      String repeatingPart = match.group(1)!;

      // Convert the non-repeating part to a fraction
      Fraction nonRepeatingFraction = nonRepeatingPart.isNotEmpty
          ? Fraction.fromDouble(double.parse("0.$nonRepeatingPart"))
          : Fraction(0, 1);

      // Calculate the repeating fraction using the formula
      int repeatingLength = repeatingPart.length;
      int repeatingNumber = int.parse(repeatingPart);
      Fraction repeatingFraction = Fraction(
          repeatingNumber, (math.pow(10, repeatingLength) - 1).toInt());

      // Combine the non-repeating and repeating fractions
      Fraction decimalFraction = nonRepeatingFraction + repeatingFraction;

      // Add the integer part and return the result
      Fraction result = Fraction(int.parse(integerPart), 1) + decimalFraction;
      return result.reduce();
    } else {
      // If no recurring pattern is found, simply parse the string as a double and convert to a fraction
      Fraction result = Fraction.fromDouble(double.parse(recurringDecimal));
      return result.reduce();
    }
  }

  // Convert fraction to decimal
  static String fractionToDecimal(int numerator, int denominator) {
    double decimal = numerator / denominator;
    return decimal.toStringAsFixed(10);
  }

  // Convert decimal to fraction
  static String decimalToFraction(String decimal) {
    int index = decimal.indexOf('.');
    int wholePart = int.parse(decimal.substring(0, index));
    int decimalPart = int.parse(decimal.substring(index + 1));
    int decimalLength = decimal.length - index - 1;

    int denominator = math.pow(10, decimalLength) as int;
    int numerator = wholePart * denominator + decimalPart;
    int gcd = _gcd(numerator, denominator);

    return '${numerator ~/ gcd}/${denominator ~/ gcd}';
  }

  // Convert recurring decimal to fraction
  static String recurringToFraction(String recurringDecimal) {
    int index = recurringDecimal.indexOf('.');
    int wholePart = int.parse(recurringDecimal.substring(0, index));

    String decimalPart = recurringDecimal.substring(index + 1);
    int nonRepeatingPartLength = decimalPart.indexOf('(');
    String nonRepeatingPart = decimalPart.substring(0, nonRepeatingPartLength);
    String repeatingPart = decimalPart.substring(
        nonRepeatingPartLength + 1, decimalPart.length - 1);

    int nonRepeatingPartInt =
        nonRepeatingPart.isNotEmpty ? int.parse(nonRepeatingPart) : 0;
    int repeatingPartInt = int.parse(repeatingPart);

    int denominator1 = math.pow(10, repeatingPart.length) as int;
    denominator1 -= 1;
    int denominator2 = nonRepeatingPart.isNotEmpty
        ? math.pow(10, nonRepeatingPart.length) as int
        : 1;
    int denominator = denominator1 * denominator2;

    int numerator = wholePart * denominator +
        (repeatingPartInt * denominator2 + nonRepeatingPartInt);
    int gcd = _gcd(numerator, denominator);

    return '${numerator ~/ gcd}/${denominator ~/ gcd}';
  }

  // Convert fraction to recurring decimal
  static String fractionToRecurring(int numerator, int denominator) {
    int wholePart = numerator ~/ denominator;
    int remainder = numerator % denominator;
    Map<int, int> remainderPositions = {};
    List<int> decimalPart = [];

    while (remainder != 0 && !remainderPositions.containsKey(remainder)) {
      remainderPositions[remainder] = decimalPart.length;
      remainder *= 10;
      decimalPart.add(remainder ~/ denominator);
      remainder %= denominator;
    }

    String result = '$wholePart.';

    if (remainder == 0) {
      result += decimalPart.join();
    } else {
      int index = remainderPositions[remainder]!;
      result += '${decimalPart.sublist(0, index).join()}(${decimalPart.sublist(index).join()})';
    }

    return result;
  }

  static String toRecurringDecimal(Fraction fraction) {
    // Convert the fraction to a decimal
    double decimalValue = fraction.toDouble();

    // Get the integer part
    int integerPart = decimalValue.toInt();

    // Get the decimal part
    double decimalPart = decimalValue - integerPart;

    // Check if the number is already an integer
    if (decimalPart == 0) {
      return integerPart.toString();
    }

    // Convert the decimal part to a fraction
    Fraction decimalFraction = Fraction.fromDouble(decimalPart);

    // Find the recurring pattern
    String recurringPattern = _findRecurringPattern(decimalFraction);

    if (recurringPattern.isNotEmpty) {
      return '$integerPart.($recurringPattern)';
    } else {
      // If no recurring pattern is found, return the original decimal value
      return decimalValue
          .toStringAsFixed(8); // You can set the desired precision
    }
  }

  static String _findRecurringPattern(Fraction fraction) {
    // A simple implementation using the long division method
    String result = "";
    Map<int, int> remainders = {};
    int remainder = fraction.numerator;

    while (remainder != 0 && !remainders.containsKey(remainder)) {
      remainders[remainder] = result.length;
      remainder *= 10;
      result += (remainder ~/ fraction.denominator).toString();
      remainder %= fraction.denominator;
    }

    // Check if a recurring pattern was found
    if (remainder != 0) {
      int start = remainders[remainder]!;
      String nonRepeatingPart = result.substring(0, start);
      String repeatingPart = result.substring(start);
      return nonRepeatingPart.isEmpty
          ? repeatingPart
          : "$nonRepeatingPart($repeatingPart)";
    } else {
      return ""; // No recurring pattern found
    }
  }

  // Helper function to find the greatest common divisor (GCD)
  static int _gcd(int a, int b) {
    return b == 0 ? a : _gcd(b, a % b);
  }
}
