import 'package:flutter/material.dart';
import 'package:myday/screens/signUp.dart';
import 'package:myday/screens/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myday/screens/startPage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home:StartPage()
    );
  }
}
