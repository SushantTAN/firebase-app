import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/models/user.dart';
import 'package:firebaseapp/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase
  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get use {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebase(user));
      .map(_userFromFirebase);
  }

  //sign in anonymously
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously(); 
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email, pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;  
    }
  }

  //register
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData( '0', 'newbrewMember', 100);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;  
    }
  }

  //signout
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}