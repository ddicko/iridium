import 'package:flutter/material.dart';

class NkoNumber {
  static const numbers = ['߀', '߁', '߂', '߃', '߄', '߅', '߆', '߇', '߈', '߉'];
  static const ordinals = ['߀߲', '߁߭', '߂߲', '߃߲', '߄߲', '߅߲', '߆߲', '߇߲', '߈߲', '߉߲'];

  static String of(int number) {
    String nkoNumber = "";
    final value = number.toString();

    for (int i = 0; i < value.length; i++) {
      nkoNumber += numbers[int.parse(value[i])];
    }

    return nkoNumber;
  }

  static String ordinalOf(int number) => ordinals[number];
}

String translateInt(BuildContext context, num number, bool isNko) {
  final value = number.toString();

  if (!isNko) return value; // No need to Translate

  String translatedNumber = "";

  for (int i = 0; i < value.length; i++) {
    translatedNumber += NkoNumber.numbers[int.parse(value[i])];
  }

  return translatedNumber;
}

// String translateString(BuildContext context, String word) {
//   final words = {"default": "default", "sepia": "sepia", "night": "night"};

//   return words[word] ?? "";
// }
