import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/AllScreen/loginScreen.dart';
import 'package:ride_share_app/AllScreen/mainscreen.dart';

import 'AllScreen/registrationScreen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
     initialRoute: MainScreen.idScreen,
     routes: {
       RegistrationScrren.idScreen: (context)=> RegistrationScrren(),
       LogInScreen.idScreen: (context) => LogInScreen(),
       MainScreen.idScreen: (context) => MainScreen(),

     },
    );
  }
}

