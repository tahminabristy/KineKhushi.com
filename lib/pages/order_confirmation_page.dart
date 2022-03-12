import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/auth/firebase_auth_service.dart';
import 'package:flutter_ts_2021/db/FirestoreHelper.dart';
import 'package:flutter_ts_2021/models/cart_model.dart';
import 'package:flutter_ts_2021/models/order_model.dart';
import 'package:flutter_ts_2021/pages/order_successful_page.dart';
import 'package:flutter_ts_2021/pages/productList_page_user.dart';
import 'package:flutter_ts_2021/provider/cart_provider.dart';
import 'package:flutter_ts_2021/provider/order_provider.dart';
import 'package:flutter_ts_2021/utils/constants.dart';
import 'package:flutter_ts_2021/utils/helpers.dart';
import 'package:provider/provider.dart';

import 'order_successful_page.dart';
import 'order_successful_page.dart';

class OrderConfirmationPage extends StatefulWidget {
  static final String routeName ='/order_confirmation_page';

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  late OrderProvider _orderProvider;
  late CartProvider _cartProvider;
  late String _customerId;
  bool isInit =true;
  bool isLoading =true;
  String _paymentRadioDefaultValue = PaymentMethod.cod;



  @override
  void didChangeDependencies() {

    if(isInit){
      _orderProvider=Provider.of<OrderProvider>(context);
      _cartProvider=Provider.of<CartProvider>(context);
      _customerId = ModalRoute.of(context)!.settings.arguments as String;
      _orderProvider.getorderConstants().then((_){
        setState(() {
          isLoading=false;
        });

      });
      isInit= false;

    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),) :
          SingleChildScrollView(
            child: Column(
              children: [
                buildInvoiceUpper(),
                buildInvoiceLower(),
                ElevatedButton(
                    onPressed: (){
                      _placeOrder();
                    },
                    child: Text('PLACE ORDER'))

              ],
            ),
          )

    );
  }

  Widget buildInvoiceUpper() {
    return Card(
      elevation: 10,
        child: Column(
            children:[
           Column(
           children:
             _cartProvider.cartList.map((model)=>ListTile(
             title: Text(model.productName),
             subtitle: Text('${model.price}x${model.qyt}',style: TextStyle(fontWeight: FontWeight.bold),),
             trailing:Text('$takaSymbol${_cartProvider.getPriceWithQuantity(model)}')
             )).toList()


              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Divider(
                  height: 1,
                ),
              ),
              
              Column(
                children: [
                  ListTile(
                    title:Text('Total:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),) ,
                    trailing: Text('$takaSymbol ${_cartProvider.cartItemsTotalPrice}'),
                  ),
                  ListTile(
                    title:Text('After Discount(${_orderProvider.orderConstantsModel.discount}):',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),) ,
                    trailing: Text('$takaSymbol${_orderProvider.getPriceAfterDiscount(_cartProvider.cartItemsTotalPrice)}'),
                  ),
                  ListTile(
                    title:Text('VAT(${_orderProvider.orderConstantsModel.vat}%):',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),) ,
                    trailing: Text('$takaSymbol${_orderProvider.getPriceAfterAddingVat(_cartProvider.cartItemsTotalPrice)}'),
                  ),
                  ListTile(
                    title:Text('Delivery Charge:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),) ,
                    trailing: Text('$takaSymbol${_orderProvider.orderConstantsModel.deliveryCharge}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  ListTile(
                    title:Text('Grand Total:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),) ,
                    trailing: Text('$takaSymbol${_orderProvider.grandTotalPrice(_cartProvider.cartItemsTotalPrice)}'),
                  )
                ],
              )
              
    
             ]
            )  
          );
  }

  Widget buildInvoiceLower() {
    return Column(
      children: [
        ListTile(
          title: Text(PaymentMethod.cod),
         leading: Radio<String>(
            value: PaymentMethod.cod,
            groupValue: _paymentRadioDefaultValue,
            onChanged: (value){
              setState(() {
                _paymentRadioDefaultValue=value!;
              });

            }

        ),
        ),
        ListTile(
          title: Text(PaymentMethod.online),
          leading: Radio<String>(
            value: PaymentMethod.online,
            groupValue: _paymentRadioDefaultValue,
            onChanged: (value){

              setState(() {
                _paymentRadioDefaultValue=value!;
              });

            }

        ),
        ),
      ],

    );

  }
  void _placeOrder(){
    final orderModel=OrderModel(
      customerID: _customerId,
      userID: FirebaseAuthService.currentUser?.uid,
      orderStatus: OrderStatus.pending,
      vat: _orderProvider.orderConstantsModel.vat,
      discount: _orderProvider.orderConstantsModel.discount,
      deliveryCharge:_orderProvider.orderConstantsModel.deliveryCharge,
      paymentMethod: _paymentRadioDefaultValue,
      timestamp: Timestamp.fromDate(DateTime.now()),
      grandTotal: _orderProvider.grandTotalPrice(_cartProvider.cartItemsTotalPrice),

    );
    print(orderModel);
    showMessage(context, 'Please wait');
    _orderProvider.addNewOrder(orderModel,_cartProvider.cartList).then((_){
      _cartProvider.clearCart();
      Navigator.pushNamedAndRemoveUntil(context, OrderSucessfulPage.routeName, ModalRoute.withName(ProductListPageforUser.routeName));

    });


  }
}

