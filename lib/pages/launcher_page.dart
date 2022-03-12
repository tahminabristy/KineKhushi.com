import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ts_2021/auth/firebase_auth_service.dart';
import 'package:flutter_ts_2021/pages/dashboard_page.dart';
import 'package:flutter_ts_2021/pages/login_page.dart';
import 'package:flutter_ts_2021/pages/productList_page_user.dart';

class LauncherPage extends StatefulWidget {
  static final String routeName ='/laucher_name';


  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(FirebaseAuthService.currentUser==null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
      else{
        FirebaseAuthService.isCurrentUserAdmin(FirebaseAuthService.currentUser!.uid)
            .then((value){
           if(value){
             Navigator.pushReplacementNamed(context, DashBoardPage.routeName);
           }
           else{
             Navigator.pushReplacementNamed(context, ProductListPageforUser.routeName);
           }
        });
      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
