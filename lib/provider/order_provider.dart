import 'package:flutter/foundation.dart';
import 'package:flutter_ts_2021/db/FirestoreHelper.dart';
import 'package:flutter_ts_2021/models/cart_model.dart';
import 'package:flutter_ts_2021/models/order_constants_model.dart';
import 'package:flutter_ts_2021/models/order_model.dart';

class OrderProvider with ChangeNotifier{
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> getorderConstants() async{
    FirestoreHelper.getOrderConstants().listen((docSnapshot) {
      if(docSnapshot.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(docSnapshot.data()!);
        notifyListeners();
      }
    });
  }

  num getPriceAfterDiscount(num total){
    return(total-((total * orderConstantsModel.discount!)/100)).round();
  }
  num getPriceAfterAddingVat(num total){
    return ((getPriceAfterDiscount(total)*orderConstantsModel.vat!)/100).round();
  }
  num grandTotalPrice(num total){
    return getPriceAfterDiscount(total)+ getPriceAfterAddingVat(total)+orderConstantsModel.deliveryCharge!;

  }
  Future <void>addNewOrder(OrderModel orderModel,List<CartModel>cartModels) async{
    return FirestoreHelper.addNewOrder(orderModel, cartModels);
  }

}