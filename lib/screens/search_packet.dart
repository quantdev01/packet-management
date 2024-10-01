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
              const SizedBox(height: 30),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('clients')
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

                      return ListTile(
                        title: Text(
                          '${clientData['lta_number']}  ${clientData['name']}',
                          style: TextStyle(fontSize: kDefaultFontSize),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${clientData['total_to_pay']}\$',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            color: kBlueColor,
                          ),
                        ),
                        trailing: Text('Status'),
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
                    return ListTile(
                      title: Text(productData['name']),
                      subtitle: Text(
                          'Poid: ${productData['weight']}kg, Prix: ${productData['total_price']}\$'),
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
}
