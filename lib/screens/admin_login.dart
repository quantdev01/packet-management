import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
      body: Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(text: 'Se connecter/Admin'),
              const SizedBox(height: 30),
              myTextField(
                  controller: controllerUsername,
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textSize: kSizeTextBox,
                  isPassword: false,
                  icon: FontAwesomeIcons.circleUser,
                  hintText: 'Nom d\'utilisateur'),
              const SizedBox(height: 30),
              myTextField(
                controller: controllerPassword,
                height: kBoxHeight,
                width: kBoxWidht,
                textSize: kSizeTextBox,
                isPassword: true,
                icon: FontAwesomeIcons.lock,
                hintText: 'Mot de passe',
              ),
              const SizedBox(height: 30),
              myButton(
                buttonColor: kBlueColor,
                textColor: kWhiteColor,
                text: 'Se connecter',
                height: kBoxHeight,
                width: kBoxWidht,
                textSize: kSizeTextBox,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
