import 'package:entree_sortie/screens/admin_login_mobile.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueColor,
        title: const Text('Agence Kindu Maendeleo'),
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
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Bienvenue',
                      style: TextStyle(
                        color: kBlueColor,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const UserLogin(),
                  //       ),
                  //     );
                  //   },
                  //   child: myButton(
                  //     buttonColor: kBlueColor,
                  //     textColor: kWhiteColor,
                  //     text: 'Utilisateur',
                  //     height: kBoxHeightMobile,
                  //     width: kBoxWidhtMobile,
                  //     textSize: kSizeTextBoxMobile,
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminLoginMobile()),
                      );
                    },
                    child: myButton(
                      buttonColor: kBlueColor,
                      textColor: Colors.white,
                      text: 'Administrateur',
                      height: kBoxHeightMobile,
                      width: kBoxWidhtMobile,
                      textSize: kSizeTextBoxMobile,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
