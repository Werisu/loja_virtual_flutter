import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/datas/cart_product.dart';
import 'package:lopa_app_flutter/models/user_model.dart';
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

  void upDatePrices(){
    notifyListeners();
  }

  double getProductPrice(){
    double price = 0.00;
    for(CardProduct c in product){
      price += c.quantity * c.productsData.price;
    }
    return price;
  }

  double getDiscount(){
    return getProductPrice() * discountPorcentage / 100;
  }

  double getShipPrice(){
    return 9.99;
  }

  Future<String> finishOrder() async{

    if(product.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productPrice = getProductPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await
    Firestore.instance.collection("orders").add(
      {
        "clientId": user.firebaseUser.uid,
        "product": product.map((cartProduct) => cartProduct.toMap()).toList(),
        "shipPrice": shipPrice,
        "productPrice": productPrice,
        "discount": discount,
        "totalPrice": productPrice - discount + shipPrice,
        "status": 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("orders").document(refOrder.documentID).setData(
      {
        "orderId":refOrder.documentID
      }
    );

    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
    .collection("cart").getDocuments();

    for(DocumentSnapshot doc in querySnapshot.documents){
      doc.reference.delete();
    }

    product.clear();

    coupomCode = null;
    discountPorcentage = 0;

    isLoading = false;

    notifyListeners();

    return refOrder.documentID;

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