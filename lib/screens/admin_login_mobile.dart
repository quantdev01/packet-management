import 'package:entree_sortie/screens/search_packet_mobile.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

class AdminLoginMobile extends StatefulWidget {
  const AdminLoginMobile({super.key});

  @override
  State<AdminLoginMobile> createState() => _AdminLoginMobileState();
}

class _AdminLoginMobileState extends State<AdminLoginMobile> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isPassword = true;
  GetStorage box = GetStorage();

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
              fontSize: 20,
              color: Colors.white,
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueColor,
        title: const Text(
          'Connectez-vous/Admin',
          style: TextStyle(
            color: kWhiteColor,
          ),
        ),
      ),
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
                  myTextField(
                    hintText: 'Nom d\'utilisateur',
                    icon: FontAwesomeIcons.circleUser,
                    isPassword: false,
                    height: kBoxHeightMobile,
                    width: kBoxWidhtMobile,
                    textSize: kSizeTextBoxMobile,
                    controller: controllerUsername,
                  ),
                  const SizedBox(height: 20),
                  myTextFieldPassword(
                    controller: controllerPassword,
                    height: kBoxHeightMobile,
                    width: kBoxWidhtMobile,
                    textSize: kSizeTextBoxMobile,
                    icon: FontAwesomeIcons.lock,
                    hintText: 'Mot de passe',
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (controllerUsername.text == 'admin' &&
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
                            builder: (context) => const SearchPacketMobile(),
                          ),
                        );
                        box.write('isLogin', true);
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
                      height: kBoxHeightMobile,
                      width: kBoxWidhtMobile,
                      textSize: kSizeTextBoxMobile,
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
