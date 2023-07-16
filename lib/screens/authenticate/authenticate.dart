

import 'package:firebaseapp/screens/authenticate/register.dart';
import 'package:firebaseapp/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleFunc(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return SignIn(toggleSignin: toggleFunc);
    }else{
      return Register(toggleSignin: toggleFunc);
    }
  }
}