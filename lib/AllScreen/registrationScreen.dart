

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/AllScreen/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_share_app/AllScreen/mainscreen.dart';
import 'package:ride_share_app/AllWidgets/progressDailog.dart';
import 'package:ride_share_app/main.dart';

class RegistrationScrren extends StatelessWidget {
  static const String idScreen = 'registrationScreen';
  

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  

  void registerNewUser(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
       showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
         
            return ProgressDialog(
              message: 'Creating New User Please Wait', 
            );
          });
      final firebaseUser = (await _firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text, password: passwordController.text)
              .catchError  ((errMsg) {
                Navigator.pop(context);
        displayToastMessage('Error Msg: 01 ' + errMsg.toString(), context);
      })).user;
      if (firebaseUser != null) {
        //user created
        Map userDataMap = {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
        };
        userRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage('New user created', context);
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.idScreen, (route) => false);
      } else {
        Navigator.pop(context);
        //error occured - display
        displayToastMessage('New User has not been created', context);
      }
    }  catch (err) {
      Navigator.pop(context);
      displayToastMessage('Error Msg: 02 ' + err.toString(), context);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  height: 350,
                  width: 250,
                  image: AssetImage('images/logo.png'),
                ),
                Text(
                  'Login As Rider',
                  style: TextStyle(fontFamily: 'Brand Bold', fontSize: 24),
                ),
                SizedBox(
                  height: 08,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
                SizedBox(
                  height: 08,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: Colors.black,
                      ),
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
                SizedBox(
                  height: 08,
                ),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      labelText: 'User Name',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
                SizedBox(
                  height: 08,
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      labelText: 'Phone Number',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.length < 5 ||
                          nameController.text.isEmpty) {
                        displayToastMessage(
                            'Name must be 5 charectar', context);
                      } else if (emailController.text.isEmpty ||
                          !emailController.text.contains(RegExp(
                              '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.[com]'))) {
                        displayToastMessage('Email is not valid', context);
                      } else if (phoneController.text.isEmpty||phoneController.text.isEmpty) {
                        displayToastMessage('Phone number required', context);
                      } else if (passwordController.text.isEmpty ||
                          passwordController.text.length < 8) {
                        displayToastMessage(
                            'password must be 9 cherectars', context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    child: Text('SignUp')),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LogInScreen.idScreen, (route) => false);
                    },
                    child: Text('Already, Have an acount..'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  return Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 4,fontSize: 20);
}
