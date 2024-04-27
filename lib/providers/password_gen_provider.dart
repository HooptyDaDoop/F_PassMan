import 'dart:math';
import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  String password = "";

  // MARK: Use uppercase
  bool useUpper = false;
  void setUseUpper(bool value) async {
    useUpper = value;
    notifyListeners();
  }

  bool getUseUpper() {
    return useUpper;
  }

  // MARK: Split on 4th
  bool splitOnFourth = false;
  void setSplitByThree(bool value) async {
    splitOnFourth = value;
    notifyListeners();
  }

  bool getSplitByThree() {
    return splitOnFourth;
  }

  // MARK: Enclosing
  bool enclose = true;
  void setEnclosement(bool value) async {
    enclose = value;
    notifyListeners();
  }

  bool getEnclosement() {
    return enclose;
  }

  // MARK: Surround Character
  String surroundCharacter = "";
  void setSurroundCharacter(String value) async {
    surroundCharacter = value;
    notifyListeners();
  }

  String getSurroundCharacter() {
    return surroundCharacter;
  }

  PasswordProvider();

  String alpha = "abcdefghijklmnopqrstuvwxyz";
  String num = "0123456789";
  String special = "!@#\$%&_+=\\?";

  // MARK: Main logic
  void generatePassword({
    required int length,
  }) async {
    password = "";

    // MARK: If split on 4th
    if (splitOnFourth == true) {
      int temp = length % 4;
      if (temp != 0) {
        length = 4 * Random().nextInt(8);
      }

      bool useNumbers = Random().nextBool();

      for (int i = 0; i < length / 4; i++) {
        for (int j = 0; j < 3; j++) {
          String current = alpha[Random().nextInt(alpha.length)];
          current = switchCaseMaybe(current);
          password += current;
        }

        switch (useNumbers) {
          case true:
            password += num[Random().nextInt(num.length)];
            break;
          case false:
            password += special[Random().nextInt(special.length)];
            break;
        }
      }
    }

    // MARK: If not split on 4th
    else {
      String charsCombined = "$alpha$num$special";
      List<String> allChars = [];

      for (var char in charsCombined.runes) {
        String current = String.fromCharCode(char);
        if (allChars.contains(current) == false) {
          allChars.add(current);
        }
      }

      for (int i = 0; i < length; i++) {
        String current = allChars[Random().nextInt(allChars.length)];

        if (alpha.contains(current) == true) {
          current = switchCaseMaybe(current);
        }

        password += current;
      }
    }

    // MARK: Enclosing
    if (enclose == true) {
      password = "$surroundCharacter$password$surroundCharacter";
    }

    notifyListeners();
  }

  // MARK: Case switcharoo (50% chance)
  String switchCaseMaybe(String switcharoo) {
    bool shouldSwitchCase = Random().nextInt(100) % 2 == 0;

    if (shouldSwitchCase && useUpper == true) {
      return switcharoo.toUpperCase();
    } else {
      return switcharoo;
    }
  }
}
