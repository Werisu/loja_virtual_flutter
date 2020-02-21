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
    title = snapshot.data["title"];
    price = snapshot.data["preco"];
    images = snapshot.data["imagens"];
    sizes = snapshot.data["sizes"];
  }
}