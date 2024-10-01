import 'package:flutter/material.dart';

const kSizeTitle = 70.0;

kTextStyleButtons(
  Color textColor,
  double textSize,
) =>
    TextStyle(
      fontSize: textSize,
      color: textColor,
      fontFamily: 'Condensed',
    );
const kSizeTextBox = 20.0;
const kSizeNormalText = 35.0;
const kSizeTextBoxMobile = kSizeTextBox - 5.0;
const kTextStyleNormal = TextStyle(
  fontSize: 25,
  color: Colors.black87,
);

const Color kBlueColor = Color.fromARGB(255, 0, 75, 172);
const Color kRedColor = Color.fromARGB(255, 172, 0, 0);
const Color kWhiteColor = Colors.white;

const double kBoxHeight = 86 - 20;
const double kBoxWidht = 492 - 20;
const double kBoxHeightMobile = kBoxHeight - 30;
const double kBoxWidhtMobile = kBoxWidht - 200;

const String kBackgroundImage = 'assets/images/background1.jpg';
