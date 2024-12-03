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
const kSizeTextBoxMobile = kSizeTextBox - 2.5;
const kTextStyleNormal = TextStyle(
  fontSize: 25,
  color: Colors.black87,
);

const kTextStyleMobile = TextStyle(
  // fontSize: 14,
  color: Colors.black87,
  fontWeight: FontWeight.bold,
);

const kTextStyleTableTitleMobile = TextStyle(
  // fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const Color kBlueColor = Color.fromARGB(255, 0, 75, 172);
const Color kRedColor = Color.fromARGB(255, 172, 0, 0);
const Color kWhiteColor = Colors.white;

const double kSizedBoxHeight = 20;

const double kBoxHeight = 86 - 10;
const double kBoxWidht = 492 - 10;
const double kBoxHeightMobile = kBoxHeight - 20;
const double kBoxWidhtMobile = kBoxWidht - 200;

const String kBackgroundImage = 'assets/images/background1.jpg';
