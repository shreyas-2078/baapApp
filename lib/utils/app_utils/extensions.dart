// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color generateColorFromHex(String hexColor) {
  if (hexColor.length != 6) {
    throw ArgumentError("Hex color should have 6 characters.");
  }
  final String hex = "0xFF$hexColor";
  return Color(int.parse(hex));
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getInitials() {
    List<String> parts = this.split(" ");
    if (parts.length >= 2) {
      String firstNameInitial = parts[0][0];
      return firstNameInitial.toUpperCase();
    } else {
      return this.substring(0, 2).toUpperCase();
    }
    // return "${this.substring(0, 1)} ${this.substring(this.length - 1)}";
    //  name.substring(0, 1) + name.substring(name.length - 1);
  }
}

extension RupeesFormatter on int {
  String inRupeesFormat() {
    return indianRupeesFormat.format(this);
  }
}

final indianRupeesFormat = NumberFormat.currency(
  name: "INR",
  locale: 'en_IN',
  decimalDigits: 2,
  symbol: '₹ ',
);

final australianDollarsFormat = NumberFormat.currency(
  name: "AUD",
  locale: 'en_AU',
  decimalDigits: 2,
  symbol: '\$',
);

extension RegexExt on String {
  bool validateEmail() => RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool validateUPI() =>
      RegExp(r'^[a-zA-Z0-9.\-_]{2,49}@[a-zA-Z._]{2,49}').hasMatch(this);
}
