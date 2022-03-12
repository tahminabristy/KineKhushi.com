
import 'package:cloud_firestore/cloud_firestore.dart';

final String ORDER_ID='orderId';
final String CUSTOMER_ID='customerID';
final String USER_ID='userID';
final String GRAND_TOTAL='grandTotal';
final String DISCOUNT='discount';
final String DELIVERY_CHARGE='deliveryCharge';
final String VAT='vat';
final String ORDER_STATUS='orderStatus';
final String PAYMENT_METHOD='paymentMehod';
final String ORDER_TIMESTAMP = 'orderTimestamp';



class OrderModel{
  String? orderId;
  Timestamp? timestamp;
  String? customerID;
  String? userID;
  num? grandTotal;
  int? discount;
  int? deliveryCharge;
  int? vat;
  String? orderStatus;
  String? paymentMethod;


  OrderModel({

      this.orderId,
      this.customerID,
      this.userID,
      this.grandTotal,
      this.discount,
      this.deliveryCharge,
      this.vat,
      this.orderStatus,
      this.paymentMethod,
      this.timestamp
  });

  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      ORDER_ID :orderId,
      CUSTOMER_ID:customerID,
      USER_ID:userID,
      GRAND_TOTAL:grandTotal,
      DISCOUNT:discount,
      VAT:vat,
      ORDER_STATUS:orderStatus,
      PAYMENT_METHOD:paymentMethod,
      ORDER_TIMESTAMP:timestamp

    };
    return map;
  }

  OrderModel.fromMap(Map<String,dynamic>map){
    orderId = map[ORDER_ID];
    userID = map[USER_ID];
    customerID = map[CUSTOMER_ID];
    grandTotal = map[GRAND_TOTAL];
    discount = map[DISCOUNT];
    deliveryCharge = map[DELIVERY_CHARGE];
    vat = map[VAT];
    orderStatus = map[ORDER_STATUS];
    paymentMethod = map[PAYMENT_METHOD];
    timestamp = map[ORDER_TIMESTAMP];


  }

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, customerID: $customerID, userID: $userID, grandTotal: $grandTotal, discount: $discount, deliveryCharge: $deliveryCharge, vat: $vat, orderStatus: $orderStatus, paymentMehod: $paymentMethod, timestamp: $timestamp}';
  }
}