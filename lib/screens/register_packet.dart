import 'package:entree_sortie/screens/add_packet.dart';
import 'package:entree_sortie/screens/user_login.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLogin(),
                        ),
                      );
                    },
                    child: backToPrevious(context),
                  ),
                  const Center(
                    child: Text(
                      'Enregistrement',
                      style: TextStyle(
                        fontSize: kSizeTitle,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  goHomeButton(context),
                ],
              ),
            ),
            const SizedBox(height: kSizedBoxHeight),
            myTextField(
              controller: controllerPacketName,
              height: kBoxHeight,
              width: kBoxWidht,
              textSize: kSizeTextBox,
              isPassword: false,
              icon: FontAwesomeIcons.boxOpen,
              hintText: 'Nom de l\'éxpediteur',
            ),
            const SizedBox(height: kSizedBoxHeight),
            myTextField(
              controller: controllerLtaNumber,
              height: kBoxHeight,
              width: kBoxWidht,
              textSize: kSizeTextBox,
              isPassword: false,
              icon: FontAwesomeIcons.idBadge,
              hintText: 'Numéro LTA',
            ),
            const SizedBox(height: kSizedBoxHeight),
            GestureDetector(
              onTap: () {
                if (controllerLtaNumber.text.isNotEmpty &&
                    controllerPacketName.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPacket(
                        ltaNumber: controllerLtaNumber.text,
                        clientName: controllerPacketName.text,
                      ),
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connexion reussi'),
                    backgroundColor: Colors.green, // Warning color
                    duration: Duration(seconds: 3), // Duration of SnackBar
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
            const SizedBox(height: kSizedBoxHeight),
          ],
        ),
      ),
    );
  }
}
