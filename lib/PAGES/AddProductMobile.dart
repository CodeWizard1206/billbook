import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vinays_billbook/UI/COMPONENTS/AddCategory.dart';
import 'package:vinays_billbook/UI/COMPONENTS/AddProduct.dart';
import 'package:vinays_billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';

class AddProductMobile extends StatefulWidget {
  AddProductMobile({
    Key key,
  }) : super(key: key);

  @override
  _AddProductMobileState createState() => _AddProductMobileState();
}

class _AddProductMobileState extends State<AddProductMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                  ),
                  buttonText: '',
                  leadingIconData: Icon(
                    FlutterIcons.bars_faw,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Add Product Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Add Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
            AddCategory(),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Add Product',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
            AddProduct(),
          ],
        ),
      ),
    );
  }
}
