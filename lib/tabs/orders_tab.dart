import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/Screens/login_screen.dart';
import 'package:lopa_app_flutter/models/user_model.dart';
import 'package:lopa_app_flutter/tiles/order_tile.dart';
import 'package:path_provider/path_provider.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid)
        .collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView(
              children: snapshot.data.documents.map(
                  (doc) => OrderTile(doc.documentID)
              ).toList(),
            );
          }
        },
      );

    }else{

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.list,
              size: 80.0, color: Theme.of(context).primaryColor,),
            SizedBox(height: 16.0,),
            Text(
              "Faça o login para ver pedidos!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
            )
          ],
        ),
      );

    }

  }
}
