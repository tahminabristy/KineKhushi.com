
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/auth/firebase_auth_service.dart';
import 'package:flutter_ts_2021/pages/card_page.dart';
import 'package:flutter_ts_2021/provider/cart_provider.dart';
import 'package:flutter_ts_2021/provider/product_provider.dart';
import 'package:flutter_ts_2021/widgets/drawer_widgets.dart';
import 'package:flutter_ts_2021/widgets/product_item_user.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class ProductListPageforUser extends StatefulWidget {
  static final String routeName ='/product_page_for_user';

  @override
  _ProductListPageforUserState createState() => _ProductListPageforUserState();
}

class _ProductListPageforUserState extends State<ProductListPageforUser> {
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    _productProvider= Provider.of<ProductProvider>(context);
    _productProvider.getProductsforUser();

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavUser(),
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context,CartPage.routeName);
              },
              child: Stack(
                children: [
                  IconButton(
                      onPressed:(){
                        Navigator.pushNamed(context,CartPage.routeName);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 25,
                      )),
                  Positioned(
                    right: 0,
                    child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child:
                            Consumer<CartProvider>(
                              builder: (context,provider,_)=>FittedBox(
                                child: Text('${provider.cartList.length}'),
                              )
                            )
                                )),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                FirebaseAuthService.logout().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName));
              },
              icon: Icon(Icons.logout, size: 25)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 0.5,
            children: _productProvider.productList
                .map((product) => ProductItemUser(product))
                .toList()),
      ),
    );
  }
}
