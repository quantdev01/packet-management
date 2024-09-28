import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminLoginMobile extends StatelessWidget {
  const AdminLoginMobile({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueColor,
        title: const Text(
          'Connectez-vous/Admin',
          style: TextStyle(fontFamily: 'Condensed'),
        ),
      ),
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
              // title('Se connecter/Admin'),
              const SizedBox(height: 30),
              myTextField(
                hintText: 'Nom d\'utilisateur',
                icon: FontAwesomeIcons.circleUser,
                isPassword: false,
                height: kBoxHeightMobile,
                width: kBoxWidhtMobile,
                textSize: kSizeTextBoxMobile,
                controller: controllerUsername,
              ),
              const SizedBox(height: 30),
              myTextField(
                hintText: 'Mot de passe',
                icon: FontAwesomeIcons.lock,
                isPassword: true,
                height: kBoxHeightMobile,
                width: kBoxWidhtMobile,
                textSize: kSizeTextBoxMobile,
                controller: controllerPassword,
              ),
              const SizedBox(height: 30),
              myButton(
                buttonColor: kBlueColor,
                textColor: kWhiteColor,
                text: 'Se connecter',
                height: kBoxHeightMobile,
                width: kBoxWidhtMobile,
                textSize: kSizeTextBoxMobile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
