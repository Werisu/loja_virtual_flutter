import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductsData produto;

  ProductScreen(this.produto);

  @override
  _ProductScreenState createState() => _ProductScreenState(produto);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductsData produto;

  _ProductScreenState(this.produto);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
