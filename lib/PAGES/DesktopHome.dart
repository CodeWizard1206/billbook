import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/DatabaseHandler.dart';
import 'package:vinays_billbook/MODELS/ProductModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CategorizedProductList.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:vinays_billbook/UI/COMPONENTS/DataLoader.dart';
import 'package:vinays_billbook/UI/COMPONENTS/SearchResult.dart';

class DesktopHome extends StatefulWidget {
  final double pageWidth;
  const DesktopHome({
    Key key,
    this.pageWidth,
  }) : super(key: key);
  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  final TextEditingController _controller = new TextEditingController();
  Widget mainChildWidget;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    List<String> _data = Provider.of<List<String>>(context);
    if (_data != null) {
      mainChildWidget = CategorizedProductList(
        categoryData: _data,
      );
      firstTime = false;
    }
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
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: 5.0,
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                    maxLines: 1,
                    onChanged: (value) {
                      if (value == '') {
                        setState(() {
                          mainChildWidget = CategorizedProductList(
                            categoryData: _data,
                          );
                        });
                      } else {
                        setState(() {
                          mainChildWidget = StreamProvider<List<ProductModel>>(
                            create: (context) => getSearchResult(),
                            child: SearchResult(
                              searchData: value,
                            ),
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: (_data != null)
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: (MediaQuery.of(context).size.width * 0.60),
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: mainChildWidget,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialMenuButton(
                      filledColor: kPrimaryColor,
                      leadingIconData: Icon(
                        FlutterIcons.shopping_cart_faw5s,
                        color: Colors.white,
                      ),
                      buttonText: 'View Cart',
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart').then(
                          (value) => setState(() {
                            print('empty responce!!!');
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : DataLoader(),
    );
  }
}
