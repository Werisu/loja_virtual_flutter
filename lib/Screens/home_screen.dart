import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/tabs/category_tab.dart';
import 'package:lopa_app_flutter/tabs/home_tab.dart';
import 'package:lopa_app_flutter/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryTab(),
        ),
      ],
    );
  }
}
