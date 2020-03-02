import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {

  String category;

  String id;
  String title;

  double price;

  List images;
  List sizes;

  ProductsData.fromDocment(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["titulo"];
    price = snapshot.data["preco"] + 0.0;
    images = snapshot.data["imagens"];
    sizes = snapshot.data["sizes"];
  }

  Map<String, dynamic> toResumeMap(){
    return{
      "title": title,
      "price": price
    };
  }
}