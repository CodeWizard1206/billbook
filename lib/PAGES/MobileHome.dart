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

class MobileHome extends StatefulWidget {
  const MobileHome({Key key}) : super(key: key);
  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  final TextEditingController _controller = new TextEditingController();
  Widget mainChildWidget;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    List<String> _data = Provider.of<List<String>>(context);
    if (_data != null && firstTime) {
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
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
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
                            mainChildWidget =
                                StreamProvider<List<ProductModel>>(
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
              ),
            ],
          ),
        ),
      ),
      body: (_data != null)
          ? Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: mainChildWidget,
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
                      buttonText: '',
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
