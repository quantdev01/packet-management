import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entree_sortie/screens/admin_login_mobile.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPacketMobile extends StatefulWidget {
  const SearchPacketMobile({super.key});

  @override
  State<SearchPacketMobile> createState() => _SearchPacketMobileState();
}

class _SearchPacketMobileState extends State<SearchPacketMobile> {
  TextEditingController controllerSearch = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kBackgroundImage),
                    fit: BoxFit.cover,
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
                              builder: (context) => AdminLoginMobile()),
                        );
                      },
                      child: backToPreviousMobile(context),
                    ),
                    Text(
                      'Rechereche un colis',
                      style: TextStyle(
                        fontSize: 25,
                        color: kWhiteColor,
                      ),
                    ),
                    goHomeButtonMobile(context),
                  ],
                ),
              ),
              const SizedBox(height: kSizeNormalText),
              TextField(
                controller: controllerSearch,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                  ),
                  hintText: 'Nom du client / Numéro LTA',
                ),
              ),
              const SizedBox(height: kSizedBoxHeight),
              Container(
                height: 50,
                color: kBlueColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('clients')
                    .orderBy('created_at', descending: true)
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

                      //* TO know when the packet was taken

                      final hour1 = modifiedAt.toDate().hour;
                      final minute1 = modifiedAt.toDate().minute;
                      final day1 = modifiedAt.toDate().day;
                      final month1 = modifiedAt.toDate().month;

                      return Card(
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
                                    child: Text(
                                      '${clientData['name']}',
                                      style: kTextStyleMobile,
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('$day/$month $hour:$minute'),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                          Text('$day1/$month1 $hour1:$minute1'),
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
                              fontSize: 15,
                              color: kBlueColor,
                            ),
                          ),
                          trailing: isDelivered
                              ? Icon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Colors.green,
                                )
                              : Icon(
                                  FontAwesomeIcons.spinner,
                                  color: Colors.orange,
                                ),
                          onTap: () => _showProductsDialog(context, clientId),
                        ),
                      );
                    },
                  );
                },
              ),
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
                height: 200,
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
                        icon: Icon(FontAwesomeIcons.penToSquare),
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
              child: const Text('Close'),
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
            decoration: const InputDecoration(
              labelText: "Poid à retirer (Kg)",
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
                    'total_price':
                        double.parse(newTotalPrice.toStringAsFixed(1)),
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
    });
  }
}
