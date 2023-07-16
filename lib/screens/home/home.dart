import 'package:firebaseapp/screens/home/brew_list.dart';
import 'package:firebaseapp/screens/home/stettings_form.dart';
import 'package:firebaseapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebaseapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebaseapp/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 60),
          child: SettingsForm(),
        );

      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("brewcrew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person), 
              label: Text('logout'),
              ),

            FlatButton.icon(
              onPressed: (){
                _showSettingsPanel();
              }, 
              icon: Icon(Icons.settings), 
              label: Text('settings'),
              ),
          ],
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              ),
          ),
          child: BrewList(),
          ),
      ),
    );
  }
}