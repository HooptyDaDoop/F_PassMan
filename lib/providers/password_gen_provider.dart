import 'dart:math';
import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  String password = "";
  bool? useUpper;

  bool splitByThree;

  void setSplitByThree(bool value) async {
    splitByThree = value;
    notifyListeners();
  }

  bool getSplitByThree() {
    return splitByThree;
  }

  PasswordProvider({
    required bool this.useUpper,
    required this.splitByThree,
  });

  String alpha = "abcdefghijklmnopqrstuvwxyz";
  String num = "0123456789";
  String special = "!@#\$%^&*()_-+={[:;\"'|\\<,>.?/]}";

  void generatePassword({
    required String surroundCharacter,
    required int length,
    required bool enclose,
  }) async {
    password = "";

    //#region Splitting By Three
    if (splitByThree == true) {
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
    } else {
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

    if (enclose == true) {
      password = "$surroundCharacter$password$surroundCharacter";
    }

    notifyListeners();
  }

  String switchCaseMaybe(String switcharoo) {
    bool shouldSwitchCase = Random().nextBool();

    if (shouldSwitchCase) {
      return switcharoo.toUpperCase();
    } else {
      return switcharoo;
    }
  }
}
