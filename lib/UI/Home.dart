import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/PAGES/DesktopHome.dart';
import 'package:billbook/PAGES/MobileHome.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (Constants.isLoggedIn) {
      return StreamProvider<List<String>>(
        create: (context) => getCategories(),
        child: ScreenTypeLayout.builder(
          desktop: (context) => DesktopHome(
            pageWidth: (MediaQuery.of(context).size.width * 0.60),
          ),
          tablet: (context) => DesktopHome(
            pageWidth: (MediaQuery.of(context).size.width * 0.70),
          ),
          mobile: (context) => MobileHome(),
        ),
      );
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
  }
}
