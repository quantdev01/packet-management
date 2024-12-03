import 'package:entree_sortie/firebase_options.dart';
import 'package:entree_sortie/screens/home_or_mobile_screen.dart';
import 'package:entree_sortie/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

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
        colorScheme: ColorScheme.fromSeed(seedColor: kBlueColor),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeOrMobileScreen(),
    );
  }
}
