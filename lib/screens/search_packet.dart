import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entree_sortie/screens/user_login.dart';
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
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //TODO Find a way of making the search to work without
        //TODO rebuilding all the screen
        //* alerts
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLogin()),
                          );
                        },
                        child: backToMenuButton(context)),
                    const Center(
                      child: Text(
                        'Recherchez un colis',
                        style: TextStyle(
                          fontSize: kSizeTitle,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                    goHomeButton(context),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controllerSearch,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                  hintText: 'Nom du client / numero LTA',
                ),
              ),
              const SizedBox(height: kSizedBoxHeight),
              Container(
                height: 50,
                color: kBlueColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 50),
                  child: Table(
                    children: [
                      TableRow(children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Numéro LTA',
                            style: kTextStyleTableTitleMobile,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Infos Client',
                            style: kTextStyleTableTitleMobile,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Dépot',
                            style: kTextStyleTableTitleMobile,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Retrait',
                            style: kTextStyleTableTitleMobile,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'Etat',
                            style: kTextStyleTableTitleMobile,
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('clients')
                    .orderBy(
                      'created_at',
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No clients found.'));
                  }

                  final clients = snapshot.data!.docs;

                  // Filter clients based on search query (search by name or LTA number)
                  final filteredClients = clients.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = data['name'].toString().toLowerCase();
                    final ltaNumber =
                        data['lta_number'].toString().toLowerCase();
                    return name.contains(searchQuery) ||
                        ltaNumber.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true, // Required for nesting in ScrollView
                    itemCount: filteredClients.length,
                    itemBuilder: (context, index) {
                      final clientData =
                          filteredClients[index].data() as Map<String, dynamic>;
                      final clientId = filteredClients[index].id;

                      // Check the status field (default: false)
                      final isDelivered = clientData['status'] ?? false;
                      // final totalWeight = clientData['total_weight'] ?? 0;
                      Timestamp createdAt = clientData['created_at'];
                      Timestamp modifiedAt = clientData['modified_at'];

                      final hour = createdAt.toDate().hour;
                      final minute = createdAt.toDate().minute;
                      final day = createdAt.toDate().day;
                      final month = createdAt.toDate().month;
                      final year = createdAt.toDate().year;

                      //*  TO know when the packet was taken

                      final hour1 = modifiedAt.toDate().hour;
                      final minute1 = modifiedAt.toDate().minute;
                      final day1 = modifiedAt.toDate().day;
                      final month1 = modifiedAt.toDate().month;
                      final year1 = modifiedAt.toDate().year;
                      final months = [
                        'Empty',
                        'Janvier',
                        'Février',
                        'Mars',
                        'Avril',
                        'Mai',
                        'Juin',
                        'Juillet',
                        'Aout',
                        'Septembre',
                        'Octobre',
                        'Novembre',
                        'Decembre'
                      ];

                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          child: ListTile(
                            dense: true,
                            title: Table(
                              border: TableBorder.all(color: Colors.white30),
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${clientData['lta_number']}',
                                          style: kTextStyleNormal,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${clientData['name']}'),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '$day ${months[month]} $year à ${hour}h${minute}min'),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '$day1 ${months[month1]} $year1 à ${hour1}h${minute1}min'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        isDelivered
                                            ? 'Livrer'
                                            : 'En cours de livraison', // Display status based on `status`
                                        style: TextStyle(
                                          color: isDelivered
                                              ? Colors.green
                                              : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            subtitle: Text(
                              '${clientData['total_to_pay']}\$',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                color: kBlueColor,
                              ),
                            ),
                            onTap: () => _showProductsDialog(context, clientId),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Show dialog to display products (subcollection) for a specific client
  void _showProductsDialog(BuildContext context, String clientId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Colis du client $clientId"),
          content: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('clients')
                .doc(clientId)
                .collection('products')
                .snapshots(),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: whileWaiting());
              }

              if (!productSnapshot.hasData ||
                  productSnapshot.data!.docs.isEmpty) {
                return const Text('Aucun Produit trouver');
              }

              final products = productSnapshot.data!.docs;

              return SizedBox(
                height: double.infinity,
                width: 300,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final productData =
                        products[index].data() as Map<String, dynamic>;
                    final productId = products[index].id;
                    // final weightController = TextEditingController(
                    //     text: productData['weight'].toString());

                    return ListTile(
                      title: Text(productData['name']),
                      subtitle: Text(
                          'Poid: ${productData['weight']}kg, Prix: ${productData['total_price']}\$'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          double totalPrice = double.tryParse(
                                  productData['total_price'].toString()) ??
                              0.0;
                          double weight = double.tryParse(
                                  productData['weight'].toString()) ??
                              0.0;
                          _showEditWeightDialog(
                            context,
                            clientId,
                            productId,
                            weight,
                            totalPrice,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to edit the weight and update price
  void _showEditWeightDialog(BuildContext context, String clientId,
      String productId, double currentWeight, double currentPrice) {
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Retrait du colis"),
          content: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Poid à retirer (KG)",
              hintText: '0.0',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (double.parse(weightController.text) <= currentWeight) {
                  double newWeight =
                      currentWeight - double.parse(weightController.text);
                  double newTotalPrice =
                      currentPrice / currentWeight * newWeight;
                  // Update the product weight and recalculate price
                  FirebaseFirestore.instance
                      .collection('clients')
                      .doc(clientId)
                      .collection('products')
                      .doc(productId)
                      .update({
                    'weight': newWeight,
                    'total_price': double.parse(
                      newTotalPrice.toStringAsFixed(1),
                    ),
                    // .toStringAsFixed(1),
                  });

                  // Recalculate the total weight and total to pay for the client
                  _recalculateClientTotal(clientId);

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Poid à retirer supérieur au poid du colis'),
                      backgroundColor: Colors.red, // Warning color
                      duration: Duration(seconds: 3), // Duration of SnackBar
                    ),
                  );
                }
              },
              child: const Text('Retirer'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  // Recalculate the total weight and total to pay for the client
  void _recalculateClientTotal(String clientId) async {
    final productsSnapshot = await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId)
        .collection('products')
        .get();

    num totalWeight = 0;
    num totalToPay = 0;

    for (var product in productsSnapshot.docs) {
      final productData = product.data();
      totalWeight += productData['weight'];
      totalToPay += productData['total_price'];
    }

    // Update the client document with the recalculated totals
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId)
        .update({
      'total_weight': totalWeight,
      'total_to_pay': totalToPay,
      'status': totalWeight == 0, // Update status based on total weight
      'modified_at': Timestamp.now(),
    });
  }
}
