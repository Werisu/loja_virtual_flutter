import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/Screens/product_screen.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';

class ProductTile extends StatelessWidget {
  final String tipe;
  final ProductsData produto;

  ProductTile(this.tipe, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(produto))
        );
      },
      child: Card(
        child: tipe == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      produto.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          /*Text(
                            produto.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),*/
                          Text(
                            "R\$ ${produto.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                produto.images[0],
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Text(
                            produto.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),*/
                    Text(
                      "R\$ ${produto.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
