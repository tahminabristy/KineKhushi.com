class CartModel{
  String productId;
  String productName;
  num price;
  int qyt;

  CartModel({
      required this.productId,
      required this.productName,
      required this.price,
      this.qyt=1
      });

  Map<String,dynamic>toMap(){
    var map= <String,dynamic>{
      'productId':productId,
      'productName': productName,
      'price': price,
      'qyt': qyt
    };
    return map;
  }

  factory CartModel.fromMap(Map<String,dynamic>map)=> CartModel(
      productId: map['productId'],
      productName: map['productName'],
      price: map['price'],
      qyt: map['qyt']

  );

  @override
  String toString() {
    return 'CartModel{productId: $productId, productName: $productName, price: $price, qyt: $qyt}';
  }
}