import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/provider/product_provider.dart';
import 'package:flutter_ts_2021/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductListpageAdminState extends StatefulWidget {
  static final String routeName ='/product_list_page_admin_page';


  @override
  _ProductListpageAdminStateState createState() => _ProductListpageAdminStateState();
}

class _ProductListpageAdminStateState extends State<ProductListpageAdminState> {
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Products'),
      ),
      body: ListView.builder(
        itemCount: _productProvider.productList.length,
          itemBuilder:(context,index){
            final product = _productProvider.productList[index];
            return ListTile(
              leading: Image.network(product.imageDownloadUrl!,width: 100,height: 100,fit: BoxFit.cover,),
              title: Text(product.name!),
              subtitle: Text(product.category!),
              trailing: Text('$takaSymbol${product.price!}'),
            );
          }
      ),

    );
  }
}
