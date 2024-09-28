import 'package:entree_sortie/screens/take_credit.dart';
import 'package:flutter/material.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RetrievePacket extends StatelessWidget {
  const RetrievePacket({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerWeightNbr = TextEditingController();
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
            child: Center(
              child: Column(
                children: [
                  backToMenuButton(context),
                  const Text(
                    'Retrait Colis',
                    style: TextStyle(
                      fontSize: ksizeTitle,
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Client : 4993342223',
            style: TextStyle(
              fontSize: kSizeNormalText,
            ),
          ),
          const Text(
            'Nom du colis : Matela',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const Text(
            'En stock : 10kg',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 30),
          myTextField(
            hintText: 'Nombres de kilos à retirer',
            icon: FontAwesomeIcons.weightScale,
            isPassword: false,
            height: kBoxHeight,
            width: kBoxWidht,
            textSize: kSizeTextBox,
            controller: controllerWeightNbr,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  text: 'Crédit',
                  textSize: kSizeTextBox,
                ),
              ),
              const SizedBox(width: 40),
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
                  buttonColor: kBlueColor,
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textColor: kWhiteColor,
                  text: 'Retirer',
                  textSize: kSizeTextBox,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
