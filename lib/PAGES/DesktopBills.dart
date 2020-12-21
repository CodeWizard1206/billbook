import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vinays_billbook/MODELS/CartModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:vinays_billbook/UI/COMPONENTS/BillsItem.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:vinays_billbook/UI/COMPONENTS/DataLoader.dart';

class DesktopBills extends StatefulWidget {
  final double pageWidth;
  DesktopBills({
    Key key,
    this.pageWidth,
  }) : super(key: key);

  @override
  _DesktopBillsState createState() => _DesktopBillsState();
}

class _DesktopBillsState extends State<DesktopBills> {
  @override
  Widget build(BuildContext context) {
    List<CartModel> _data = Provider.of<List<CartModel>>(context);
    if (_data != null) {
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
                    'Bills',
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
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: widget.pageWidth,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: _data.map((bill) {
                return BillItem(
                  data: bill,
                );
              }).toList(),
            ),
          ),
        ),
      );
    } else if (_data == null) {
      return DataLoader();
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: widget.pageWidth,
        child: Center(
          child: Text(
            'no bill found!',
            style: TextStyle(
              fontSize: 28.0,
            ),
          ),
        ),
      );
    }
  }
}
