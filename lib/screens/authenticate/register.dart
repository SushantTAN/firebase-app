import 'dart:ui';

import 'package:firebaseapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebaseapp/services/auth.dart';
import 'package:firebaseapp/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleSignin;
  Register({this.toggleSignin});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text fild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('register in to brew crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label:  Text('Sign in'),
            onPressed: (){
              widget.toggleSignin();
            },
          ),
        ],
        ),

      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),

                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                  ),

                   SizedBox(height: 20),

                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter a password 6 characters or longer' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password= val;
                    });
                  },
                ), 

                 SizedBox(height: 20),

                 RaisedButton(
                   color: Colors.pink[400],
                   child: Text("register",
                   style: TextStyle(
                     color: Colors.white
                   ),
                   ),
                   onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if(result == null) {
                       setState(() {
                         error = 'error found';
                         loading = false;
                       });
                     }
                    }
                   },
                 ),

                 SizedBox(height: 20),

                Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                  ),
                ),

              ]
            ),
          ),
        
        ),
      );
  }
}