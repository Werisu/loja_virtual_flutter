import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lopa_app_flutter/datas/cart_product.dart';
import 'package:lopa_app_flutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CardModel extends Model{

  UserModel user;

  List<CardProduct> product = [];

  CardModel(this.user);

  void addCartItem(CardProduct cardProduct){
    product.add(cardProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").add(cardProduct.toMap()).then((doc){
      cardProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CardProduct cardProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cardProduct.cid).delete();

    product.remove(cardProduct);

    notifyListeners();
  }

}