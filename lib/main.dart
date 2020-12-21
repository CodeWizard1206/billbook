import 'package:flutter/material.dart';
import 'package:billbook/UI/AddProductData.dart';
import 'package:billbook/UI/Bills.dart';
import 'package:billbook/UI/Cart.dart';
import 'package:billbook/UI/Home.dart';
import 'package:billbook/UI/Login.dart';
import 'package:billbook/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill-Book',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color(0xff2196f3),
        accentColor: Color(0xff2196f3),
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 22.0,
            color: kPrimaryDarkColor,
          ),
          bodyText2: TextStyle(
            fontSize: 22.0,
            color: kPrimaryDarkColor,
          ),
        ),
      ),
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/addData': (context) => AddProductData(),
        '/cart': (context) => Cart(),
        '/bills': (context) => Bills(),
      },
      initialRoute: '/',
    );
  }
}
