import 'package:entree_sortie/screens/add_packet.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPacket extends StatefulWidget {
  const RegisterPacket({super.key});

  @override
  State<RegisterPacket> createState() => _RegisterPacketState();
}

class _RegisterPacketState extends State<RegisterPacket> {
  TextEditingController controllerLtaNumber = TextEditingController();
  TextEditingController controllerPacketName = TextEditingController();
  int ltaNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Column(
                children: [
                  backToMenuButton(context),
                  const Center(
                    child: Text(
                      'Enregistrement',
                      style: TextStyle(
                        fontSize: ksizeTitle,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            myTextField(
              controller: controllerLtaNumber,
              height: kBoxHeight,
              width: kBoxWidht,
              textSize: kSizeTextBox,
              isPassword: false,
              icon: FontAwesomeIcons.idBadge,
              hintText: 'Numéro LTA',
            ),
            const SizedBox(height: 30),
            myTextField(
              controller: controllerPacketName,
              height: kBoxHeight,
              width: kBoxWidht,
              textSize: kSizeTextBox,
              isPassword: false,
              icon: FontAwesomeIcons.boxOpen,
              hintText: 'Nom de l\'éxpediteur',
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPacket(
                      ltaNumber: controllerLtaNumber.text,
                      clientName: controllerPacketName.text,
                    ),
                  ),
                );
              },
              child: myButton(
                buttonColor: kBlueColor,
                height: kBoxHeight,
                width: kBoxWidht,
                textColor: kWhiteColor,
                text: 'Suivant',
                textSize: kSizeTextBox,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
