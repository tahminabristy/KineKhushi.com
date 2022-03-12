

import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/models/customer_model.dart';
import 'package:flutter_ts_2021/provider/customer_provider.dart';
import 'package:flutter_ts_2021/utils/helpers.dart';
import 'package:provider/provider.dart';

import 'order_confirmation_page.dart';

class CheckoutCustomerInfoPage extends StatefulWidget {
  static final String routeName ='/checkout_customer_info';

  @override
  _CheckoutCustomerInfoPageState createState() => _CheckoutCustomerInfoPageState();
}

class _CheckoutCustomerInfoPageState extends State<CheckoutCustomerInfoPage> {
  final _searchPhoneController= TextEditingController();
  final _customerNameController= TextEditingController();
  final _customerPhoneController= TextEditingController();
  final _customerAddressController= TextEditingController();
  final _customerEmailController= TextEditingController();
  late CustomerProvider _customerProvider;
  CustomerModel? _customerModel = CustomerModel();
  final _formkey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _customerProvider = Provider.of<CustomerProvider>(context);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _searchPhoneController.dispose();
   _customerNameController.dispose();
    _customerEmailController.dispose();
    _customerPhoneController.dispose();
    _customerAddressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Information'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white
            ),
            onPressed: (){
              print('ok');
              _saveInfoFromWidgetWithValidation();
            },
            child:

                Text('NEXT'),
              )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              _findCustomerSection(),
              SizedBox(height: 10,),
              _buildCustomerFormSection()

            ],
          ),
        ),
      ),

    );
  }



  Future _findExistingCustomer() async{
    FocusScope.of(context).unfocus();
    if(_customerPhoneController.text.isEmpty){
      showMessage(context, 'Provide a phone number');
      return;
    }

    _customerModel  = await _customerProvider.findCustomer(_customerPhoneController.text);
    if(_customerModel != null){
      showMessage(context, 'Found');
      setState(() {
        _customerNameController.text = _customerModel!.customerName!;
        _customerPhoneController.text = _customerModel!.customerPhone!;
        _customerEmailController.text = _customerModel!.customerEmail!;
        _customerAddressController.text = _customerModel!.customerAddress!;
      });

    }

    else{
      showMessage(context, 'Not Found');
    }



  }


  Widget _findCustomerSection(){
    return Column(
          children: [
            Text(
              'Existing Customer?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _customerPhoneController ,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _findExistingCustomer();
                    },
                  )),
            ),


          ],


    );

  }


  Widget _buildCustomerFormSection(){
    return Form(
      key: _formkey,
      child: Column(
              children: [
                Text('New Customer?',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller:_customerNameController ,
                  decoration: InputDecoration(
                    hintText:'Customer Name',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value){
                    return null;
                  },
                  onSaved: (value){
                    _customerModel!.customerName=value!;

                  },

                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller:_customerPhoneController ,
                  decoration: InputDecoration(
                    hintText:'Customer Phone',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value){
                    return null;
                  },
                  onSaved: (value){
                    _customerModel!.customerPhone=value!;

                  },

                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller:_customerEmailController ,
                  decoration: InputDecoration(
                    hintText:'Customer Email',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value){
                    return null;
                  },
                  onSaved: (value){
                    _customerModel!.customerEmail=value!;

                  },

                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller:_customerAddressController ,
                  decoration: InputDecoration(
                    hintText:'Customer Street Address',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value){
                    return null;
                  },
                  onSaved: (value){
                    _customerModel!.customerAddress=value!;

                  },

                ),
                SizedBox(
                  height: 10,
                ),

              ],



      ),
    );

  }
  void _saveInfoFromWidgetWithValidation() async {
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if(_customerModel!.customerId == null) {
        final customerId = await _customerProvider.addCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmationPage.routeName, arguments: customerId);
      }else{
        await _customerProvider.updateCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmationPage.routeName, arguments: _customerModel!.customerId);
      }

    }
  }

}



