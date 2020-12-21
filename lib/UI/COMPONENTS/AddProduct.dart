import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
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
  ProductModel _deleteData;

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
                if (this._nameController.text != this._deleteData.productName &&
                    this._deleteData != null) {
                  this._deleteData = null;
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
                    if (this._deleteData == null) {
                      List<ProductModel> _data = await getProductList();
                      setState(() {
                        this.progressing = false;
                      });
                      showDialog(
                        context: context,
                        builder: (_) => SimpleDialog(
                          title: Text(
                            'Select a Product',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: _data
                              .map(
                                (product) => SimpleDialogOption(
                                  onPressed: () {
                                    this._deleteData = product;
                                    this._nameController.text =
                                        product.productName;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    product.productName,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    } else {
                      bool _result = deleteProduct(this._deleteData.id);
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
                        this._deleteData = null;
                        this._nameController.text = '';
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
