import 'package:entree_sortie/screens/register_packet.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPacket extends StatefulWidget {
  final String ltaNumber;
  final String clientName;

  const AddPacket({
    super.key,
    required this.ltaNumber,
    required this.clientName,
  });

  @override
  State<AddPacket> createState() => _AddPacketState(
        clientName,
        ltaNumber,
      );
}

class _AddPacketState extends State<AddPacket> {
  late String ltaNumber;
  late String clientName;
  _AddPacketState(
    this.clientName,
    this.ltaNumber,
  );

  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerPacketName = TextEditingController();
  TextEditingController controllerPacketNumber = TextEditingController();
  TextEditingController controllerTotalWeight = TextEditingController();
  TextEditingController controllerPriceForWeight = TextEditingController();

  @override
  void dispose() {
    controllerPacketName.dispose();
    controllerTotalWeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addPacket(String name, String weight) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(name), Text(weight)],
      );
    }

    List<Widget> packetsList = [];

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPacket(),
                            ),
                          );
                        },
                        child: const Icon(
                          FontAwesomeIcons.backward,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Numéro LTA : $ltaNumber',
                    style: kTextStyleNormal,
                  ),
                  Text(
                    'Nom de l\'expediteur : $clientName',
                    style: kTextStyleNormal,
                  ),
                  const SizedBox(height: 30),
                  myTextField(
                    controller: controllerPacketName,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    isPassword: false,
                    icon: FontAwesomeIcons.idBadge,
                    hintText: 'Nom du colis',
                  ),
                  const SizedBox(height: 30),
                  myTextField(
                    controller: controllerPacketNumber,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    isPassword: false,
                    icon: FontAwesomeIcons.idBadge,
                    hintText: 'Nombre colis',
                  ),
                  const SizedBox(height: 30),
                  myTextField(
                    controller: controllerTotalWeight,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    isPassword: false,
                    icon: FontAwesomeIcons.idBadge,
                    hintText: 'Total Kilos',
                  ),
                  const SizedBox(height: 30),
                  myTextField(
                    controller: controllerPriceForWeight,
                    height: kBoxHeight,
                    width: kBoxWidht,
                    textSize: kSizeTextBox,
                    isPassword: false,
                    icon: FontAwesomeIcons.idBadge,
                    hintText: 'Prix Discuter par kilos',
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Colis ajouter',
                    style: kTextStyleNormal,
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: packetsList,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        packetsList = [
                          Text("State changed"),
                          Text(
                            'New state',
                          )
                        ];
                        // packetsList.add(addPacket(
                        //   controllerPacketName.text,
                        //   controllerTotalWeight.text,
                        // ));
                      });
                    },
                    child: myButton(
                      buttonColor: kBlueColor,
                      height: kBoxHeight,
                      width: kBoxWidht,
                      textColor: kWhiteColor,
                      text: 'Ajouter',
                      textSize: kSizeTextBox,
                    ),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Enregistrez avec success'),
                  backgroundColor: Colors.green, // Warning color
                  duration: Duration(seconds: 2), // Duration of SnackBar
                ),
              );
              setState(() {
                packetsList = [
                  Text("State changed"),
                  Text(
                    'New state',
                  )
                ];
                // packetsList.add(addPacket(
                //   controllerPacketName.text,
                //   controllerTotalWeight.text,
                // ));
              });
              controllerId.text = '';
              controllerPacketName.text = '';
              controllerPacketNumber.text = '';
              controllerPriceForWeight.text = '';
              controllerTotalWeight.text = '';
            },
            child: myButton(
              buttonColor: kBlueColor,
              height: kBoxHeight,
              width: kBoxWidht,
              textColor: kWhiteColor,
              text: 'Enregistrer',
              textSize: kSizeTextBox,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    ));
  }
}
