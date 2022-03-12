
import 'package:flutter/foundation.dart';
import 'package:flutter_ts_2021/db/FirestoreHelper.dart';
import 'package:flutter_ts_2021/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<String> categories = [];
  List<ProductModel> productList = [];

  void getCategories() {
    FirestoreHelper.getCategories().listen((snapshot) {
      categories = List.generate(snapshot.docs.length, (index) => snapshot.docs[index].data()['name']);
    });
  }

  void getProductsforUser(){
    FirestoreHelper.getAllProductsForUser().listen((snapshot) {
      productList= List.generate(snapshot.docs.length, (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getProducts(){
    FirestoreHelper.getAllProductsForAdmin().listen((snapshot) {
      productList = List.generate(snapshot.docs.length, (index) =>ProductModel.fromMap(snapshot.docs[index].data()) );
    });

  }



  Future<void> addProduct(ProductModel productModel) => FirestoreHelper.insertNewProduct(productModel);

}