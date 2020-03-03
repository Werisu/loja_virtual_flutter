import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/datas/cart_product.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';
import 'package:lopa_app_flutter/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CardProduct cardProduct;

  CartTile(this.cardProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){

      CardModel.of(context).upDatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cardProduct.productsData.images[0],
              fit: BoxFit.cover,
            ),
          )  ,
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cardProduct.productsData.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    "Tamanho: ${cardProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cardProduct.productsData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cardProduct.quantity > 1 ?
                            (){
                              CardModel.of(context).decProduct(cardProduct);
                            } : null,
                      ),
                      Text(
                        cardProduct.quantity.toString(),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          CardModel.of(context).incProduct(cardProduct);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          CardModel.of(context).removeCartItem(cardProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: cardProduct.productsData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("Produtos").document(cardProduct.category)
        .collection("itens").document(cardProduct.pid).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            cardProduct.productsData = ProductsData.fromDocment(snapshot.data);
            return _buildContent();
          }else{
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ) :
      _buildContent()
    );
  }
}
