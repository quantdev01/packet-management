import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPacket extends StatefulWidget {
  const AddPacket({super.key});

  @override
  State<AddPacket> createState() => _AddPacketState();
}

class _AddPacketState extends State<AddPacket> {
  TextEditingController controllerId = TextEditingController();
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
                text: 'Ajouter',
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
