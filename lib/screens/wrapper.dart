
import 'package:firebaseapp/screens/authenticate/authenticate.dart';
import 'package:firebaseapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebaseapp/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //either home or auth
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}