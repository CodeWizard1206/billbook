import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/MODELS/CategoryModel.dart';
import 'package:billbook/MODELS/ProductModel.dart';
import 'package:billbook/UI/COMPONENTS/AppDrawer.dart';
import 'package:billbook/UI/COMPONENTS/CategorizedProductList.dart';
import 'package:billbook/UI/COMPONENTS/CategoryList.dart';
import 'package:billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:billbook/UI/COMPONENTS/DataLoader.dart';
import 'package:billbook/UI/COMPONENTS/SearchResult.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key key}) : super(key: key);
  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  final TextEditingController _controller = new TextEditingController();
  Widget mainChildWidget;
  bool firstTime = true;
  bool filter = false;
  List<String> _filterList = [];

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
                            filter = false;
                          });
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (value == '') {
                          setState(() {
                            mainChildWidget = CategorizedProductList(
                              categoryData: _data,
                            );
                            filter = false;
                          });
                        } else {
                          setState(() {
                            mainChildWidget =
                                StreamProvider<List<ProductModel>>(
                              create: (context) => getSearchResult(),
                              child: SearchResult(
                                searchData: value,
                                filterList: _filterList,
                              ),
                            );
                            filter = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: filter,
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Visibility(
                visible: filter,
                child: MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  buttonText: '',
                  leadingIconData: Icon(
                    FlutterIcons.filter_faw5s,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var _data = await Firestore.instance
                        .collection('Categories')
                        .getDocuments();

                    List<CategoryModel> value = _data.documents
                        .map(
                          (e) => CategoryModel(
                            name: e.data['name'],
                            added: _filterList.contains(e.data['name']),
                          ),
                        )
                        .toList();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Select a Category...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Container(
                          constraints: BoxConstraints(
                            maxHeight: 500,
                          ),
                          width: (MediaQuery.of(context).size.width - 100),
                          child: ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryList(
                                data: value[index],
                                stateChanged: (status) {
                                  if (status) {
                                    _filterList.add(value[index].name);
                                  } else {
                                    _filterList.remove(value[index].name);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        actions: [
                          MaterialMenuButton(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            buttonText: 'DONE',
                            leadingIconData: Icon(
                              FlutterIcons.check_circle_faw5s,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                mainChildWidget =
                                    StreamProvider<List<ProductModel>>(
                                  create: (context) => getSearchResult(),
                                  child: SearchResult(
                                    searchData: _controller.text,
                                    filterList: _filterList,
                                  ),
                                );
                                filter = true;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
