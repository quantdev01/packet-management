import 'package:entree_sortie/screens/retrieve_packet.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPacket extends StatefulWidget {
  const SearchPacket({super.key});

  @override
  State<SearchPacket> createState() => _SearchPacketState();
}

class _SearchPacketState extends State<SearchPacket> {
  TextEditingController controllerSearch = TextEditingController();

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
                      'Rechereche un colis',
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
            SizedBox(
              height: 50,
              child: myTextField(
                controller: controllerSearch,
                height: kBoxHeight,
                width: kBoxWidht,
                textSize: kSizeTextBox,
                isPassword: false,
                icon: FontAwesomeIcons.magnifyingGlass,
                hintText: 'Numéro LTA',
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RetrievePacket(),
                          ),
                        );
                      },
                      child: const ListTile(
                        title: Text('User'),
                        subtitle: Text('kg'),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
