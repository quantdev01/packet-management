import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/screens/home_mobile.dart';
import 'package:entree_sortie/screens/search_packet.dart';
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
              GestureDetector(
                onTap: () {
                  MediaQuery.of(context).size.width > 1200
                      ? Home()
                      : HomeMobile();
                },
                child: backToPrevious(context),
              ),
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
              GestureDetector(
                onTap: () {
                  if (controllerUsername.text == 'admin' &&
                      controllerPassword.text == 'password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connexion'),
                        backgroundColor: Colors.green, // Warning color
                        duration: Duration(seconds: 1), // Duration of SnackBar
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPacket(),
                      ),
                    );
                  } else if (controllerUsername.text == '' ||
                      controllerPassword.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Nom d\'utilisateur ou mot de passe vide'),
                        backgroundColor: Colors.orange, // Warning color
                        duration: Duration(seconds: 2), // Duration of SnackBar
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Nom d\'utilisateur ou mot de passe incorrect'),
                        backgroundColor: Colors.red, // Warning color

                        duration: Duration(seconds: 2), // Duration of SnackBar
                      ),
                    );
                  }
                },
                child: myButton(
                  buttonColor: kBlueColor,
                  textColor: kWhiteColor,
                  text: 'Se connecter',
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textSize: kSizeTextBox,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
