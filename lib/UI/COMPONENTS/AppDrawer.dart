import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              MaterialMenuButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                buttonText: '',
                leadingIconData: Icon(
                  FlutterIcons.arrow_left_faw5s,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView(
              children: [
                getListTile(
                  iconData: FlutterIcons.home_faw5s,
                  title: "HOME",
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/home');
                  },
                ),
                getListTile(
                  iconData: FlutterIcons.plus_faw5s,
                  title: "ADD",
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/addData');
                  },
                ),
                getListTile(
                  iconData: FlutterIcons.file_invoice_faw5s,
                  title: "BILLS",
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/bills');
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: MaterialMenuButton(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              filledColor: Colors.transparent,
              elevation: 0.0,
              leadingIconData: Icon(
                FlutterIcons.sign_out_faw,
                color: kPrimaryColor,
                size: 30,
              ),
              buttonText: 'LOGOUT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getListTile({IconData iconData, String title, Function onTap}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          size: 34.0,
          color: kPrimaryDarkColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
