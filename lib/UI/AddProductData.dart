import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/PAGES/AddProductDesktop.dart';
import 'package:billbook/PAGES/AddProductMobile.dart';

class AddProductData extends StatefulWidget {
  AddProductData({Key key}) : super(key: key);

  @override
  _AddProductDataState createState() => _AddProductDataState();
}

class _AddProductDataState extends State<AddProductData> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (Constants.isLoggedIn) {
      return StreamProvider<List<String>>(
        create: (context) => getCategories(),
        child: ScreenTypeLayout.builder(
          desktop: (context) => AddProductDesktop(
            pageWidth: (MediaQuery.of(context).size.width * 0.60),
          ),
          tablet: (context) => AddProductDesktop(
            pageWidth: (MediaQuery.of(context).size.width * 0.70),
          ),
          mobile: (context) => AddProductMobile(),
        ),
      );
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
  }
}
