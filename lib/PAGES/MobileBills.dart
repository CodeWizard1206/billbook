import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:billbook/MODELS/CartModel.dart';
import 'package:billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:billbook/UI/COMPONENTS/BillsItem.dart';
import 'package:billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:billbook/UI/COMPONENTS/DataLoader.dart';

class MobileBills extends StatelessWidget {
  const MobileBills({Key key}) : super(key: key);

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
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Builder(
                  builder: (context) => MaterialMenuButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Bills',
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
            children: _data.map((bill) {
              return BillItem(
                isMobile: true,
                data: bill,
              );
            }).toList(),
          ),
        ),
      );
    } else if (_data == null) {
      return DataLoader();
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
