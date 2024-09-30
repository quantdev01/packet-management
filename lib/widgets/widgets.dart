import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//* Custom button
Container myButton({
  required Color buttonColor,
  required Color textColor,
  required String text,
  required double height,
  required double width,
  required double textSize,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Text(
        text,
        style: kTextStyleButtons(
          textColor,
          textSize,
        ),
      ),
    ),
  );
}

//* Title

Widget title({
  String? text,
}) =>
    Text(
      text!,
      style: const TextStyle(
        fontSize: kSizeTitle,
        color: kWhiteColor,
        fontFamily: 'Condensed',
      ),
    );

//* Widget custom textfield
Widget myTextField({
  required String hintText,
  required IconData icon,
  required bool isPassword,
  required double height,
  required double width,
  required double textSize,
  required TextEditingController controller,
}) {
  return Column(
    children: [
      Text(
        hintText,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                prefixIconColor: Colors.grey,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: textSize,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

//* back button
Widget backToMenuButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
          child: const Icon(
            FontAwesomeIcons.backward,
            color: Colors.white,
            size: 40,
          ),
        ),
      ],
    ),
  );
}

//* Back button
Widget backToPrevious(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FontAwesomeIcons.backward,
            color: Colors.white,
            size: 40,
          ),
        ),
      ],
    ),
  );
}

//* back to previous mobile
Widget backToPreviousMobile(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FontAwesomeIcons.backward,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
