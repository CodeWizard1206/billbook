import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/MODELS/CartModel.dart';
import 'package:billbook/PAGES/DesktopBills.dart';
import 'package:billbook/PAGES/MobileBills.dart';

class Bills extends StatefulWidget {
  Bills({Key key}) : super(key: key);

  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (Constants.isLoggedIn) {
      return StreamProvider<List<CartModel>>(
        create: (context) => getBills(),
        child: ScreenTypeLayout.builder(
          desktop: (context) => DesktopBills(
            pageWidth: (MediaQuery.of(context).size.width * 0.60),
          ),
          tablet: (context) => DesktopBills(
            pageWidth: (MediaQuery.of(context).size.width * 0.70),
          ),
          mobile: (context) => MobileBills(),
        ),
      );
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
  }
}
