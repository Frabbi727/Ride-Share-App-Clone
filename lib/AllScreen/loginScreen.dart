import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_share_app/AllScreen/mainscreen.dart';
import 'package:ride_share_app/AllScreen/registrationScreen.dart';
import 'package:ride_share_app/AllWidgets/progressDailog.dart';
import 'package:ride_share_app/main.dart';

class LogInScreen extends StatelessWidget {



  static const String idScreen = 'loginScreen';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  

  void loginAutentcatUser(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: 'Authenticating Please wait',
          );
        },
      );
      final firebaseUser = (await _firebaseAuth
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .catchError((errMsg) {
        Navigator.pop(context);
        displayToastMessage('Error Msg 01: ' + errMsg.toString(), context);
      }))
          .user;
      if (firebaseUser != null) {
        userRef.child(firebaseUser.uid).once().then(
          (DataSnapshot snap) {
            if (snap.value != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.idScreen, (route) => false);
              displayToastMessage('You are Loggied in', context);
            } else {
              Navigator.pop(context);

              _firebaseAuth.signOut();

              displayToastMessage(
                  'User does not found, Create new account', context);
            }
          },
        );
      } else {
        Navigator.pop(context);
        displayToastMessage('Error occured', context);
      }
    } on PlatformException catch (err) {
      Navigator.pop(context);
      displayToastMessage('Error: 02 ' + err.toString(), context);
    } catch (err) {
      Navigator.pop(context);
      displayToastMessage('Error: 03 ' + err.toString(), context);
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
                ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          !emailController.text.contains(RegExp(
                              '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.[com]'))) {
                        displayToastMessage('Email is not valid', context);
                      } else if (passwordController.text.isEmpty ||
                          passwordController.text.length < 8) {
                        displayToastMessage(
                            'password must be 9 cherectars', context);
                      } else {
                        loginAutentcatUser(context);
                      }
                    },
                    child: Text('Login')),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RegistrationScrren.idScreen, (route) => false);
                    },
                    child: Text('Create New Account..'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
