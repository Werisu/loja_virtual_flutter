import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';

class CardProduct {

  String cid;
  String category; //id
  String pid;
  int quantity;
  String size;

  ProductsData productsData;

  CardProduct();

  CardProduct.fromDocument(DocumentSnapshot documentSnapshot){
    cid = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    pid = documentSnapshot.data["pid"];
    quantity = documentSnapshot.data["quantity"];
    size = documentSnapshot.data["size"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productsData.toResumeMap()
    };
  }

}