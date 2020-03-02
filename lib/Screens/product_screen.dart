import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lopa_app_flutter/Screens/card_screen.dart';
import 'package:lopa_app_flutter/Screens/login_screen.dart';
import 'package:lopa_app_flutter/datas/cart_product.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';
import 'package:lopa_app_flutter/models/cart_model.dart';
import 'package:lopa_app_flutter/models/user_model.dart';

class ProductScreen extends StatefulWidget {

  final ProductsData produto;

  ProductScreen(this.produto);

  @override
  _ProductScreenState createState() => _ProductScreenState(produto);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductsData produto;

  String size;

  _ProductScreenState(this.produto);

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final _formaKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(produto.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: produto.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  produto.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${produto.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: produto.sizes.map(
                        (s){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                size = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                  color: s == size ? primaryColor : Colors.grey,
                                  width: 2.0
                                )
                              ),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(s),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null ?
                    (){
                      if(UserModel.of(context).isLoggedIn()){

                        CardProduct cardProduct = CardProduct();
                        cardProduct.size = size;
                        cardProduct.quantity = 1;
                        cardProduct.pid = produto.id;
                        cardProduct.category = produto.category;

                        CardModel.of(context).addCartItem(cardProduct);

                        _scaffoldkey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Adicionado no carrinho!", textAlign: TextAlign.center,),
                            backgroundColor: Theme
                                .of(context)
                                .primaryColor,
                            duration: Duration(seconds: 3),
                          )
                        );

                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ?
                      "Adicionar ao Carrinho" : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );;
  }
}
