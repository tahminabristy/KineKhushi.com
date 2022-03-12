import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/models/cart_model.dart';
import 'package:flutter_ts_2021/provider/cart_provider.dart';
import 'package:flutter_ts_2021/utils/constants.dart';
import 'package:provider/provider.dart';

import 'checkout_customer_info_page.dart';


class CartPage extends StatefulWidget {
  static final String routeName ='/cart_page';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:  Text('Cart Page'),
      actions: [
        Consumer<CartProvider>(
          builder: (context,provider,_)=> IconButton(onPressed: (){
            provider.clearCart();
          }, icon: Icon(Icons.highlight_remove_outlined)),
        )

      ],
    ),

      body: Consumer<CartProvider>(
        builder: (context,provider,_)=> Column(
          children: [
            Expanded(child: provider.totalItemnCart==0 ? Center(child: Text('Cart is Empty')) :
                ListView.builder(
                  itemCount: provider.cartList.length,
                  itemBuilder: (context,index){
                    final cartModelP= provider.cartList[index];
                    return ListTile(
                      title: Text(cartModelP.productName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
                        
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quality: ${cartModelP.qyt}',style: TextStyle(fontSize: 17),),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                provider.decreaseQty(cartModelP);
                                
                              }, icon: Icon(Icons.remove)),
                              Text('QTY',style: TextStyle(fontSize: 18),),
                              
                              IconButton(onPressed: (){
                                provider.increaseQty(cartModelP);
                                
                              }, icon: Icon(Icons.add)),
                            ],
                          )
                        ],
                      ),
                      trailing: Text('$takaSymbol${provider.getPriceWithQuantity(cartModelP)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                     );
                      
                   
                    
                  },
                )
            ),
                  Container(
                    height: 70,
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total : ${provider.cartItemsTotalPrice}',
                          style: TextStyle(
                              color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (provider.totalItemnCart > 0)
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context,CheckoutCustomerInfoPage.routeName);
                              },
                              child: Text('Checkout',
                                  style: TextStyle(
                                    fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))
                      ],
                    ),
                  )
                ],
        )
      ),

    );
  }
}
