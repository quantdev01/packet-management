import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entree_sortie/screens/user_login.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:entree_sortie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kBackgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
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
                        'Rechereche un colis',
                        style: TextStyle(
                          fontSize: kSizeTitle,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
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
                      final totalWeight = clientData['total_weight'] ?? 0;
                      Timestamp createdAt = clientData['created_at'];

                      final hour = createdAt.toDate().hour;
                      final minute = createdAt.toDate().minute;
                      final day = createdAt.toDate().day;
                      final month = createdAt.toDate().month;
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
                      final year = createdAt.toDate().year;

                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${clientData['lta_number']}',
                              style: TextStyle(fontSize: kDefaultFontSize),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${clientData['name']}',
                              style: TextStyle(fontSize: kDefaultFontSize),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '$day ${months[month]} $year',
                              style: TextStyle(fontSize: kDefaultFontSize),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${hour}h${minute}min',
                              style: TextStyle(fontSize: kDefaultFontSize),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                        trailing: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            isDelivered
                                ? 'Livrer'
                                : 'En cours de livraison', // Display status based on `status`
                            style: TextStyle(
                              color: isDelivered ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () => _showProductsDialog(context, clientId),
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
                    final weightController = TextEditingController(
                        text: productData['weight'].toString());

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
    final weightController =
        TextEditingController(text: currentWeight.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Modifier le poids"),
          content: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Nouveau poids (kg)",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int newWeight = int.parse(weightController.text);
                double newTotalPrice = currentPrice / currentWeight * newWeight;
                // Update the product weight and recalculate price
                FirebaseFirestore.instance
                    .collection('clients')
                    .doc(clientId)
                    .collection('products')
                    .doc(productId)
                    .update({
                  'weight': newWeight,
                  'total_price': newTotalPrice,
                  // .toStringAsFixed(1),
                });

                // Recalculate the total weight and total to pay for the client
                _recalculateClientTotal(clientId);

                Navigator.of(context).pop();
              },
              child: const Text('Mettre à jour'),
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
