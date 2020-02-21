import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/datas/products_data.dart';
import 'package:lopa_app_flutter/tiles/product_tile.dart';
import 'package:path_provider/path_provider.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {

    final String titulo = snapshot.data["title"];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("Produtos").document(snapshot.documentID).
          collection("itens").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.65
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      return ProductTile("grid", ProductsData.fromDocment(snapshot.data.documents[index]));
                    }
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        return ProductTile("list", ProductsData.fromDocment(snapshot.data.documents[index]));
                      }
                  )
                ],
              );
          },
        )
      ),
    );
  }
}
