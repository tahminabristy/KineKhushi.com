import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/models/product_model.dart';
import 'package:flutter_ts_2021/provider/cart_provider.dart';
import 'package:flutter_ts_2021/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductItemUser extends StatefulWidget {
  final ProductModel productModel;
  ProductItemUser(this.productModel);

  @override
  _ProductItemUserState createState() => _ProductItemUserState();
}

class _ProductItemUserState extends State<ProductItemUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      //color: Colors.green.withOpacity(0.7),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(child: Image.network(
            widget.productModel.imageDownloadUrl!, width: double.maxFinite,
            fit: BoxFit.cover,)),
          Text(widget.productModel.name!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
          Text('$takaSymbol ${widget.productModel.price!}',
            style: TextStyle(fontSize: 18,),),
            Consumer<CartProvider>(
              builder: (context, provider, _) => ElevatedButton.icon(onPressed: (){
                provider.addToCart(widget.productModel);
              }, icon: Icon(Icons.shopping_cart),
                  label:FittedBox(child: Text(provider.isInCart(widget.productModel.id!)?'Remove from cart':'Add to Cart')))
            )


        ],
      ),

    );
  }
}
