import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lopa_app_flutter/datas/cart_product.dart';
import 'package:lopa_app_flutter/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

class CardModel extends Model{

  UserModel user;

  List<CardProduct> product = [];

  String coupomCode;
  int discountPorcentage = 0;

  bool isLoading = false;

  CardModel(this.user){
    if(user.isLoggedIn())
      _loadCartItens();
  }

  static CardModel of(BuildContext context) =>
  ScopedModel.of<CardModel>(context);

  void addCartItem(CardProduct cardProduct){
    product.add(cardProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").add(cardProduct.toMap()).then((doc){
      cardProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.coupomCode = couponCode;
    this.discountPorcentage = discountPercentage;
  }

  void removeCartItem(CardProduct cardProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cardProduct.cid).delete();

    product.remove(cardProduct);

    notifyListeners();
  }

  void decProduct(CardProduct cardProduct){
    cardProduct.quantity--;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .document(cardProduct.cid).updateData(cardProduct.toMap());

    notifyListeners();
  }

  void incProduct(CardProduct cardProduct){
    cardProduct.quantity++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
        .document(cardProduct.cid).updateData(cardProduct.toMap());

    notifyListeners();
  }

  void _loadCartItens() async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
    
    product = querySnapshot.documents.map((doc) => CardProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

}