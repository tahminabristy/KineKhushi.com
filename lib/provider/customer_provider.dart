import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ts_2021/db/FirestoreHelper.dart';
import 'package:flutter_ts_2021/models/customer_model.dart';

class CustomerProvider with ChangeNotifier{
  Future<CustomerModel?> findCustomer(String phone) async{
    final snapshot = await FirestoreHelper.findCustomerByPhone(phone);
    if(snapshot.docs.length > 0){
      final customer = CustomerModel.fromMap(snapshot.docs.first.data());
      return customer;
    }

      return null;

  }

  Future<String> addCustomer(CustomerModel customerModel) async{
    final id = await FirestoreHelper.insertNewCustomer(customerModel);
    return id;
  }
  Future<void> updateCustomer(CustomerModel customerModel) async{
    return FirestoreHelper.updateCustomer(customerModel);

  }



}