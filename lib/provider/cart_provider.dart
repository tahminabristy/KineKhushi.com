import 'package:flutter/foundation.dart';
import 'package:flutter_ts_2021/models/cart_model.dart';
import 'package:flutter_ts_2021/models/product_model.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> cartList=[];
   void addToCart(ProductModel productModel){
     if(isInCart(productModel.id!)){
       removeFromCart(productModel.id!);
     }
     else{
       cartList.add(CartModel(productId: productModel.id!,productName: productModel.name!,price: productModel.price!));
       notifyListeners();
     }
   }
  void removeFromCart(String id) {
    final cartModel = cartList.firstWhere((cartModel) => cartModel.productId == id);
         cartList.remove(cartModel);
      notifyListeners();
  }

  bool isInCart(String id){
     bool tag= false;
     for(var c in cartList){
       if(c.productId==id){
         tag=true;
         break;
       }

     }
     return tag;
   }
   void clearCart(){
     cartList.clear();
     notifyListeners();
   }

  num get totalItemnCart => cartList.length;
//num getPriceWithQty(){


  void increaseQty(CartModel cartModel) {
    var index= cartList.indexOf(cartModel);
    cartList[index].qyt += 1;
    notifyListeners();
  }

  void decreaseQty(CartModel cartModel) {
    var index= cartList.indexOf(cartModel);
    if(cartList[index].qyt>1) {
      cartList[index].qyt -= 1;
    }
    notifyListeners();
  }

  num getPriceWithQuantity(CartModel cartModelP)=> cartModelP.price * cartModelP.qyt;

  num get cartItemsTotalPrice{

    num total = 0;
    cartList.forEach((element) {
      total += element.price * element.qyt;
    });
    return total;

   /* num total=0;
    cartList.forEach((element) {
      total+=element.price*element.qyt;
    });
    return total;

    */

}



}