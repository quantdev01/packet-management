import 'package:entree_sortie/firebase_options.dart';
import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/screens/home_mobile.dart';
import 'package:entree_sortie/screens/search_packet.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Condensed',
      ),
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return const SearchPacket();
          } else if (constraints.maxHeight < 1200) {
            return const HomeMobile();
          } else {
            return const Home();
          }
        },
      ),
    );
  }
}
