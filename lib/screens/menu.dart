import 'package:entree_sortie/screens/register_packet.dart';
import 'package:entree_sortie/screens/search_packet.dart';
import 'package:entree_sortie/screens/take_credit.dart';
import 'package:flutter/material.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kBackgroundImage),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: ksizeTitle,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPacket(),
                ),
              );
            },
            child: myButton(
              buttonColor: kBlueColor,
              height: kBoxHeight,
              width: kBoxWidht,
              textColor: kWhiteColor,
              text: 'Entrées',
              textSize: kSizeTextBox,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPacket(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                    blurStyle: BlurStyle.normal,
                  )
                ],
              ),
              child: myButton(
                buttonColor: kWhiteColor,
                height: kBoxHeight,
                width: kBoxWidht,
                textColor: Colors.black,
                text: 'Sorties',
                textSize: kSizeTextBox,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TakeCredit(),
                ),
              );
            },
            child: myButton(
              buttonColor: kRedColor,
              height: kBoxHeight,
              width: kBoxWidht,
              textColor: kWhiteColor,
              text: 'Crédits',
              textSize: kSizeTextBox,
            ),
          ),
        ],
      ),
    );
  }
}
