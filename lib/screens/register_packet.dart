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
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerPacketName = TextEditingController();
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
              controller: controllerId,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enregistrez avec success'),
                    backgroundColor: Colors.green, // Warning color
                    duration: Duration(seconds: 2), // Duration of SnackBar
                  ),
                );
                controllerId.text = '';
                controllerPacketName.text = '';
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
