import 'package:entree_sortie/screens/admin_login.dart';
import 'package:entree_sortie/screens/user_login.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
              title(text: 'Continuez'),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLogin(),
                    ),
                  );
                },
                child: myButton(
                  buttonColor: kBlueColor,
                  textColor: kWhiteColor,
                  text: 'Goma entrée',
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textSize: kSizeTextBox,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserLogin()),
                  );
                },
                child: myButton(
                  buttonColor: kWhiteColor,
                  textColor: kBlueColor,
                  text: 'Kindu sortie',
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textSize: kSizeTextBox,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminLogin()),
                  );
                },
                child: myButton(
                  buttonColor: kBlueColor,
                  textColor: Colors.white,
                  text: 'Administrateur',
                  height: kBoxHeight,
                  width: kBoxWidht,
                  textSize: kSizeTextBox,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
