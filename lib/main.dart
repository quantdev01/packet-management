import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/screens/home_mobile.dart';

import 'package:flutter/material.dart';

void main() {
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
            return const Home();
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
