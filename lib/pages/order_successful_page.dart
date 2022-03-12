import 'package:flutter/material.dart';

class OrderSucessfulPage extends StatefulWidget {
  static final String routeName ='/order_successful_page';

  @override
  _OrderSucessfulPageState createState() => _OrderSucessfulPageState();
}

class _OrderSucessfulPageState extends State<OrderSucessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('images/success.png',height: 200,width: 200,),
            Text('Order have been succcessful')
          ],
        ),
      ),


    );
  }
}
