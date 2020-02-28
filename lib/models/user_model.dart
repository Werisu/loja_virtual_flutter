import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  // usuŕio atual

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onSucess,
    @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async{
      firebaseUser = user as FirebaseUser;

      await _saveUserData(userData);

      onSucess();

      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();

      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async{
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass(){

  }

  void isLoggedIn(){

  }

  Future<Null> _saveUserData(Map<String, dynamic> userData){
    this.userData = userData;
    Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}