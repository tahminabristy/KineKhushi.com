import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/auth/firebase_auth_service.dart';
import 'package:flutter_ts_2021/pages/login_page.dart';
import 'package:flutter_ts_2021/pages/productList_page_admin.dart';
import 'package:flutter_ts_2021/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'new_product_page.dart';

class DashBoardPage extends StatefulWidget {
  static final String routeName ='/dashboard_page';

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
   late ProductProvider _productProvider;
   @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context,listen: false);
    _productProvider.getProducts();
    _productProvider.getCategories();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuthService.logout().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, NewProductPage.routeName);
                },
                child: Text('ADD PRODUCT')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, ProductListpageAdminState.routeName);
                },
                child: Text('VIEW PRODUCT')),
            ElevatedButton(onPressed: () {}, child: Text('VIEW ORDERS')),
            ElevatedButton(onPressed: () {}, child: Text('CUSTOMERS')),
            ElevatedButton(onPressed: () {}, child: Text('ADD CATEGORY')),
          ],
        ),
      ),
    );
  }

  Column buildDashBoardBody() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ElevatedButton(
              onPressed: (){},
              child: Text('ADD PRODUCT')
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text('VIEW PRODUCT')
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text('VIEW ORDERS')
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text('CUSTOMERS')
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text('ADD CATEGORY')
          ),


        ],
      );
  }
}

