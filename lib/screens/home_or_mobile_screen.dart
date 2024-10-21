import 'package:entree_sortie/screens/home.dart';
import 'package:entree_sortie/screens/home_mobile.dart';
import 'package:flutter/material.dart';

class HomeOrMobileScreen extends StatelessWidget {
  const HomeOrMobileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const Home();
        } else if (constraints.maxHeight < 1200) {
          return const HomeMobile();
        } else {
          return const Home();
        }
      },
    );
  }
}
