import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/UI/COMPONENTS/AddCategory.dart';
import 'package:billbook/UI/COMPONENTS/AddProduct.dart';
import 'package:billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:billbook/UI/COMPONENTS/CustomButton.dart';

class AddProductDesktop extends StatefulWidget {
  final double pageWidth;
  const AddProductDesktop({
    Key key,
    this.pageWidth,
  }) : super(key: key);
  @override
  _AddProductDesktopState createState() => _AddProductDesktopState();
}

class _AddProductDesktopState extends State<AddProductDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  buttonText: 'MENU',
                  leadingIconData: Icon(
                    FlutterIcons.bars_faw,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Container(
                width: widget.pageWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Add Product Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42.0,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Add Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  AddCategory(),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: VerticalDivider(
                  thickness: 1.0,
                  color: kPrimaryDarkColor,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Add Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  AddProduct(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
