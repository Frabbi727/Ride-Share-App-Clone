import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  //BuildContext ctx;
  ProgressDialog({required this.message,
  
  //required this.ctx
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
            
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(width: 20,),
              Text(message,
              style: TextStyle(color: Colors.black, fontSize: 7),),
            ],
          ),
        ),
      ),
    );
  }
}
