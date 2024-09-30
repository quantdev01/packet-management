import 'dart:developer';

import 'package:entree_sortie/screens/register_packet.dart';
import 'package:entree_sortie/services/firebase_service.dart';
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
  TextEditingController controllerCredit = TextEditingController();

  //* Firebase instance
  FirebaseService firebaseService = FirebaseService();
  var isTakingCredit;

  @override
  void dispose() {
    controllerPacketName.dispose();
    controllerTotalWeight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget addPacket(String name, double weight) {
    return Row(
      children: [
        Text(
          name,
          style: kTextStyleNormal,
        ),
        SizedBox(width: 20),
        Text(
          '${weight.toStringAsFixed(1)} KG',
          style: TextStyle(
            fontSize: kSizeTextBox,
          ),
        ),
      ],
    );
  }

  List<Widget> packetsList = [];
  Map<String, dynamic> packetsListClient = {};
  double total = 0;
  double fullTotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
                icon: FontAwesomeIcons.calculator,
                hintText: 'Nombre colis',
              ),
              const SizedBox(height: 30),
              myTextField(
                controller: controllerPriceForWeight,
                height: kBoxHeight,
                width: kBoxWidht,
                textSize: kSizeTextBox,
                isPassword: false,
                icon: FontAwesomeIcons.dollarSign,
                hintText: 'Frais LTA ex(1.1)',
              ),
              const SizedBox(height: 30),
              myTextField(
                controller: controllerTotalWeight,
                height: kBoxHeight,
                width: kBoxWidht,
                textSize: kSizeTextBox,
                isPassword: false,
                icon: FontAwesomeIcons.calculator,
                hintText: 'Total Kilos',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Emprunt ?',
                    style: kTextStyleNormal,
                  ),
                  SizedBox(width: 10),
                  const Text('Oui'),
                  Radio(
                    value: 'Oui',
                    groupValue: isTakingCredit,
                    onChanged: (value) {
                      setState(() {
                        isTakingCredit = value;
                      });
                    },
                  ),
                  const Text('Non'),
                  Radio(
                    value: 'Non',
                    groupValue: isTakingCredit,
                    onChanged: (value) {
                      setState(() {
                        isTakingCredit = value;
                      });
                    },
                  )
                ],
              ),
              isTakingCredit == 'Oui'
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: myTextField(
                        hintText: 'Emprunt prix',
                        icon: FontAwesomeIcons.dollarSign,
                        isPassword: false,
                        height: kBoxHeight,
                        width: kBoxWidht,
                        textSize: kSizeTextBox,
                        controller: controllerCredit,
                      ))
                  : const SizedBox(),
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

              // ! List of packets

              const SizedBox(height: 30),
              Column(children: packetsList),
              const SizedBox(height: 30),
              Text(
                'Total à payer : ${fullTotal.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  final weight = double.parse(controllerTotalWeight.text);
                  final ltaPrice = double.parse(controllerPriceForWeight.text);

                  double credit = 0;
                  if (controllerCredit.text.isEmpty) {
                    credit = 0;
                  } else {
                    credit = double.parse(controllerCredit.text);
                  }

                  final packetName = controllerPacketName.text;

                  final packetNumber =
                      double.parse(controllerPacketNumber.text);

                  total = weight * ltaPrice + 1 + credit;

                  packetsListClient.addAll({
                    "name": packetName,
                    "weight": weight,
                    "lta_price": ltaPrice,
                    "nombres": packetNumber,
                    "emprunt_prix": credit,
                    "total_price": total.toStringAsFixed(1),
                  });
                  log('ToTal value $fullTotal');

                  setState(() {
                    if (fullTotal == 0) {
                      fullTotal = total;
                    } else {
                      fullTotal += total;
                    }

                    if (controllerPacketName.text != '' &&
                        controllerTotalWeight.text != '') {
                      packetsList.add(
                        addPacket(
                          controllerPacketName.text,
                          total,
                        ),
                      );
                    }
                    log('Colis list');
                    log(packetsListClient.toString());
                  });
                  //* Adding to firestore db

                  firebaseService.registerClient(
                    clientName: clientName,
                    ltaNumber: ltaNumber,
                    totalToPay: fullTotal.toStringAsFixed(1),
                  );

                  firebaseService.addProductToClient(
                    packetsListClient,
                    clientName,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enregistrez avec success'),
                      backgroundColor: Colors.green, // Warning color
                      duration: Duration(seconds: 2), // Duration of SnackBar
                    ),
                  );
                  //Flushing the textfields

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
                  text: 'Ajouter',
                  textSize: kSizeTextBox,
                ),
              )
            ],
          ),
        ],
      ),
    ])));
  }
}
