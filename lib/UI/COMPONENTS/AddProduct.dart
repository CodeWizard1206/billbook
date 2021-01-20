import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/MODELS/ProductModel.dart';
import 'package:billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:billbook/UI/COMPONENTS/DataLoader.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<String>>(
      create: (context) => getCategories(),
      child: AddProductMain(),
    );
  }
}

class AddProductMain extends StatefulWidget {
  AddProductMain({Key key}) : super(key: key);

  @override
  _AddProductMainState createState() => _AddProductMainState();
}

class _AddProductMainState extends State<AddProductMain> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  bool progressing = false;
  ProductModel _changableData;

  List<DropdownMenuItem> _categories = [
    DropdownMenuItem(
      value: '',
      child: Text('SELECT CATEGORY...'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<String> _data = Provider.of<List<String>>(context);
    if (_data != null) {
      _categories.clear();
      _categories.add(
        DropdownMenuItem(
          value: '',
          child: Text('SELECT CATEGORY...'),
        ),
      );
      _data.forEach((category) {
        _categories.add(
          DropdownMenuItem(
            value: category,
            child: Text(
              category.toUpperCase(),
            ),
          ),
        );
      });
      return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              enabled: !this.progressing,
              controller: this._nameController,
              decoration: InputDecoration(
                hintText: 'product name...',
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 1,
              onChanged: (value) {
                if (this._nameController.text !=
                        this._changableData.productName &&
                    this._changableData != null) {
                  this._changableData = null;
                }
              },
            ),
            SizedBox(
              height: 6.0,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: 'category',
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),
              value: this._categoryController.text,
              items: this._categories,
              onChanged: (value) {
                this._categoryController.text = value;
              },
            ),
            SizedBox(
              height: 6.0,
            ),
            TextFormField(
              enabled: !this.progressing,
              controller: this._priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'price...',
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 1,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Visibility(
                  visible: progressing,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  buttonText: 'ADD',
                  leadingIconData: Icon(
                    FlutterIcons.plus_faw5s,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (this._nameController.text != '' &&
                        this._priceController.text != '' &&
                        this._categoryController.text != '') {
                      setState(() {
                        this.progressing = true;
                      });
                      try {
                        Firestore.instance
                            .collection('Products')
                            .add(ProductModel(
                              productName: this._nameController.text,
                              productCategory: this._categoryController.text,
                              productPrice: this._priceController.text,
                              timeStamp: DateTime.now(),
                            ).toMap())
                            .then((value) {
                          setState(() {
                            this.progressing = false;
                          });
                          this._nameController.text = '';
                          this._priceController.text = '';
                          this._categoryController.text = '';
                          showFlushBar(
                            context: context,
                            title: 'Great!',
                            message: 'Data Added Successfully...',
                          );
                        });
                      } catch (e) {
                        setState(() {
                          this.progressing = false;
                        });
                        showFlushBar(
                          context: context,
                          title: 'Error!',
                          message: 'Data Addition Failed...',
                          alertStyle: true,
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),
                MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  buttonText: 'DELETE',
                  filledColor: Colors.red[400],
                  leadingIconData: Icon(
                    FlutterIcons.trash_faw5s,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      this.progressing = true;
                    });
                    if (this._changableData == null) {
                      List<ProductModel> _data = await getProductList();
                      setState(() {
                        this.progressing = false;
                      });
                      showDialog(
                        context: context,
                        builder: (_) => ProductDialog(
                          data: _data,
                          onPressed: (ProductModel product) {
                            this._changableData = product;
                            this._nameController.text = product.productName;
                            this._nameController.text = product.productName;
                            this._categoryController.text =
                                product.productCategory;
                            this._priceController.text = product.productPrice;
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      bool _result = deleteProduct(this._changableData.id);
                      if (_result) {
                        showFlushBar(
                          context: context,
                          title: 'Done!',
                          message: 'Data Deleted...',
                          alertStyle: true,
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          title: 'Error!',
                          message: 'Data Deletion Failed...',
                          alertStyle: true,
                        );
                      }
                      setState(() {
                        this.progressing = false;
                        this._changableData = null;
                        this._nameController.text = '';
                        this._categoryController.text = '';
                        this._priceController.text = '';
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),
                MaterialMenuButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  buttonText: 'UPDATE',
                  leadingIconData: Icon(
                    FlutterIcons.update_mdi,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      this.progressing = true;
                    });
                    if (this._changableData == null) {
                      List<ProductModel> _data = await getProductList();
                      setState(() {
                        this.progressing = false;
                      });
                      showDialog(
                        context: context,
                        builder: (_) => ProductDialog(
                          data: _data,
                          onPressed: (ProductModel product) {
                            this._changableData = product;
                            this._nameController.text = product.productName;
                            this._nameController.text = product.productName;
                            this._categoryController.text =
                                product.productCategory;
                            this._priceController.text = product.productPrice;
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      this._changableData.productName =
                          this._nameController.text;
                      this._changableData.productCategory =
                          this._categoryController.text;
                      this._changableData.productPrice =
                          this._priceController.text;
                      bool _result = await updateProduct(this._changableData);
                      if (_result) {
                        showFlushBar(
                          context: context,
                          title: 'Done!',
                          message: 'Data Updated...',
                          alertStyle: false,
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          title: 'Error!',
                          message: 'Data Updatation Failed...',
                          alertStyle: true,
                        );
                      }
                      setState(() {
                        this.progressing = false;
                        this._changableData = null;
                        this._nameController.text = '';
                        this._categoryController.text = '';
                        this._priceController.text = '';
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return DataLoader(
        height: 500,
        width: double.maxFinite,
      );
    }
  }
}

class ProductDialog extends StatefulWidget {
  final Function onPressed;
  final List<ProductModel> data;
  ProductDialog({Key key, this.data, this.onPressed}) : super(key: key);

  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  List<ProductModel> _data;

  @override
  void initState() {
    this._data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: TextFormField(
        // controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search...',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
        maxLines: 1,
        onChanged: (value) {
          if (value != '') {
            setState(() {
              this._data = this.widget.data;
              this._data = this
                  ._data
                  .where((element) => element.productName
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          } else {
            setState(() {
              this._data = this.widget.data;
            });
          }
        },
      ),
      // title: Text(
      //   'Select a Product',
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _data
              .map(
                (product) => SimpleDialogOption(
                  onPressed: () {
                    this.widget.onPressed(product);
                  },
                  child: ScreenTypeLayout.builder(
                    desktop: (_) => Container(
                      width: 600,
                      child: Text(
                        product.productName,
                      ),
                    ),
                    tablet: (_) => Container(
                      width: 600,
                      child: Text(
                        product.productName,
                      ),
                    ),
                    mobile: (_) => Container(
                      width: double.maxFinite,
                      child: Text(
                        product.productName,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
