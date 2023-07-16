
import 'dart:ui';

import 'package:firebaseapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:firebaseapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebaseapp/shared/constants.dart';
import 'package:firebaseapp/models/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          print(userData.sugars);

          return Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Text('Update your brew preferences',
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 20,),

              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),

              SizedBox(height: 10),

              //dropdown
               DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val ),
                ),
              
              //slider
              Slider(
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                min: 100,
                max: 900,
                divisions: 8,
                onChanged: (val) => setState(() => _currentStrength = val.round()),
              ),

              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formkey.currentState.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugars, 
                      _currentName ?? userData.name, 
                      _currentStrength ?? userData.strength
                      );
                    Navigator.pop(context);
                  }
                }
              ),


            ],
          ),
          
        );
        }else{
          print(snapshot.data);
          return Loading();
        }
        
      }
    );
  }
}