import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/screens/home_mobile.dart';
import 'package:entree_sortie/screens/register_packet.dart';
import 'package:entree_sortie/screens/search_packet.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool isPassword = true;

  Widget myTextFieldPassword({
    required String hintText,
    required IconData icon,
    required double height,
    required double width,
    required double textSize,
    required TextEditingController controller,
  }) =>
      Column(
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        child: Icon(
                          isPassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            isPassword = !isPassword;
                            controllerPassword.text = controllerPassword.text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              media > 1200 ? Home() : HomeMobile(),
                        ),
                      );
                    },
                    child: backToPrevious(context),
                  ),
                  title(text: 'Se connecter/Utilisateur'),
                  const SizedBox(height: 30),
                  myTextField(
                    controller: controllerUsername,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    isPassword: false,
                    icon: FontAwesomeIcons.circleUser,
                    hintText: 'Nom d\'utilisateur',
                  ),
                  const SizedBox(height: 30),
                  myTextFieldPassword(
                    controller: controllerPassword,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    icon: FontAwesomeIcons.lock,
                    hintText: 'Mot de passe',
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (controllerUsername.text == 'user1' &&
                          controllerPassword.text == 'password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Connexion'),
                            backgroundColor: Colors.green, // Warning color
                            duration:
                                Duration(seconds: 1), // Duration of SnackBar
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPacket(),
                          ),
                        );
                      } else if (controllerUsername.text == 'user2' &&
                          controllerPassword.text == 'password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Connexion'),
                            backgroundColor: Colors.green, // Warning color
                            duration:
                                Duration(seconds: 1), // Duration of SnackBar
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
                            duration:
                                Duration(seconds: 2), // Duration of SnackBar
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Nom d\'utilisateur ou mot de passe incorrect'),
                            backgroundColor: Colors.red, // Warning color

                            duration:
                                Duration(seconds: 2), // Duration of SnackBar
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
        ],
      ),
    );
  }
}
