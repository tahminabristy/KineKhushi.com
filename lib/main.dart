import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/pages/card_page.dart';
import 'package:flutter_ts_2021/pages/checkout_customer_info_page.dart';
import 'package:flutter_ts_2021/pages/dashboard_page.dart';
import 'package:flutter_ts_2021/pages/launcher_page.dart';
import 'package:flutter_ts_2021/pages/login_page.dart';
import 'package:flutter_ts_2021/pages/new_product_page.dart';
import 'package:flutter_ts_2021/pages/order_confirmation_page.dart';
import 'package:flutter_ts_2021/pages/order_successful_page.dart';
import 'package:flutter_ts_2021/pages/productList_page_admin.dart';
import 'package:flutter_ts_2021/pages/productList_page_user.dart';
import 'package:flutter_ts_2021/provider/cart_provider.dart';
import 'package:flutter_ts_2021/provider/customer_provider.dart';
import 'package:flutter_ts_2021/provider/order_provider.dart';
import 'package:flutter_ts_2021/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyFirebase());
}

class MyFirebase extends StatelessWidget {
  const MyFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName :(context)=> LauncherPage(),
          LoginPage.routeName :(context)=> LoginPage(),
          DashBoardPage.routeName :(context)=> DashBoardPage(),
          NewProductPage.routeName:(context) => NewProductPage(),
          ProductListpageAdminState.routeName:(context) => ProductListpageAdminState(),
          ProductListPageforUser.routeName:(context) => ProductListPageforUser(),
          CartPage.routeName:(context) => CartPage(),
          CheckoutCustomerInfoPage.routeName:(context) => CheckoutCustomerInfoPage(),
          OrderConfirmationPage.routeName:(context) => OrderConfirmationPage(),
          OrderSucessfulPage.routeName:(context)=>OrderSucessfulPage()

        },
      ),
    );
  }
}



