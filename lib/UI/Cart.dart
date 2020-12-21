import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/PAGES/DesktopCart.dart';
import 'package:billbook/PAGES/MobileCart.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (Constants.isLoggedIn) {
      return ScreenTypeLayout.builder(
        desktop: (context) => DesktopCart(
          pageWidth: (MediaQuery.of(context).size.width * 0.60),
        ),
        tablet: (context) => DesktopCart(
          pageWidth: (MediaQuery.of(context).size.width * 0.70),
        ),
        mobile: (context) => MobileCart(),
      );
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
  }
}
