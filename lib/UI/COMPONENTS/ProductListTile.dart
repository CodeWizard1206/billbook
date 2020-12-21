import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/MODELS/ProductModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:vinays_billbook/UI/COMPONENTS/DataLoader.dart';

class ProductListTile extends StatefulWidget {
  ProductListTile({Key key}) : super(key: key);

  @override
  _ProductListTileState createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => DesktopListTile(),
      tablet: (context) => DesktopListTile(),
      mobile: (context) => MobileListTile(),
    );
  }
}

class DesktopListTile extends StatefulWidget {
  DesktopListTile({Key key}) : super(key: key);

  @override
  _DesktopListTileState createState() => _DesktopListTileState();
}

class _DesktopListTileState extends State<DesktopListTile> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> _data = Provider.of<List<ProductModel>>(context);
    if (_data != null && _data.length > 0) {
      return Column(
        children: _data.map((product) {
          final TextEditingController _qtyController =
              new TextEditingController();
          final TextEditingController _priceController =
              new TextEditingController();
          _priceController.text = product.productPrice;
          product.added = Constants.kCartProductId.contains(product.id);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    product.productName,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Qty',
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
                ),
                SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 110,
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Price',
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
                      if (value == '') {
                        _priceController.text = product.productPrice;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                MaterialMenuButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                    ),
                    buttonText: '',
                    filledColor:
                        product.added ? Colors.red[400] : kPrimaryColor,
                    leadingIconData: Icon(
                      product.added
                          ? FlutterIcons.close_faw
                          : FlutterIcons.plus_faw5s,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (!product.added) {
                          if (_qtyController.text != '' &&
                              _priceController.text != '') {
                            Constants.kCartProduct.add(product.copyWith(
                              productQty: _qtyController.text,
                              productPrice: _priceController.text,
                            ));
                            Constants.kCartProductId.add(product.id);
                            product.added = !product.added;
                          }
                        } else {
                          Constants.kCartProduct.removeWhere(
                              (element) => element.id == product.id);
                          Constants.kCartProductId.remove(product.id);
                          product.added = !product.added;
                        }
                      });
                    }),
              ],
            ),
          );
        }).toList(),
      );
    } else if (_data == null) {
      return DataLoader(
        height: 50.0,
        width: double.maxFinite,
      );
    } else {
      return Container(
        height: 60.0,
        width: double.maxFinite,
        child: Center(
          child: Text(
            'NO PRODUCT FOUND',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
  }
}

class MobileListTile extends StatefulWidget {
  MobileListTile({Key key}) : super(key: key);

  @override
  _MobileListTileState createState() => _MobileListTileState();
}

class _MobileListTileState extends State<MobileListTile> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> _data = Provider.of<List<ProductModel>>(context);
    if (_data != null && _data.length > 0) {
      return Column(
        children: _data
            .map(
              (product) => MobileProductTile(
                product: product,
              ),
            )
            .toList(),
      );
    } else if (_data == null) {
      return DataLoader(
        height: 50.0,
        width: double.maxFinite,
      );
    } else {
      return Container(
        height: 60.0,
        width: double.maxFinite,
        child: Center(
          child: Text(
            'NO PRODUCT FOUND',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
  }
}

class MobileProductTile extends StatefulWidget {
  final ProductModel product;
  MobileProductTile({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _MobileProductTileState createState() => _MobileProductTileState();
}

class _MobileProductTileState extends State<MobileProductTile> {
  final TextEditingController _qtyController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  bool expanded = false;

  @override
  void initState() {
    widget.product.added = Constants.kCartProductId.contains(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _priceController.text = widget.product.productPrice;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.product.productName,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              MaterialMenuButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                ),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                leadingIconData: Icon(
                  getExpansionStatus(expanded),
                  color: kPrimaryColor,
                ),
                buttonText: '',
                elevation: 0.0,
                filledColor: Colors.transparent,
              ),
            ],
          ),
          Visibility(
            visible: expanded,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Qty',
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
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Price',
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
                      if (value == '') {
                        _priceController.text = widget.product.productPrice;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Stack(
                  children: [
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 5.0,
                      onPressed: () {
                        setState(() {
                          if (!widget.product.added) {
                            if (_qtyController.text != '' &&
                                _priceController.text != '') {
                              Constants.kCartProduct
                                  .add(widget.product.copyWith(
                                productQty: _qtyController.text,
                                productPrice: _priceController.text,
                              ));
                              Constants.kCartProductId.add(widget.product.id);
                              widget.product.added = !widget.product.added;
                            }
                          } else {
                            Constants.kCartProduct.removeWhere(
                                (element) => element.id == widget.product.id);
                            Constants.kCartProductId.remove(widget.product.id);
                            widget.product.added = !widget.product.added;
                          }
                        });
                      },
                      constraints: BoxConstraints(
                        minWidth: 50.0,
                        minHeight: 54.0,
                      ),
                      fillColor: getButtonColor(widget.product.added),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2.0,
                        ),
                        child: Icon(
                          getProductStatus(widget.product.added),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getExpansionStatus(bool expanded) {
    if (expanded) {
      return FlutterIcons.angle_up_faw5s;
    } else {
      return FlutterIcons.angle_down_faw5s;
    }
  }

  IconData getProductStatus(bool added) {
    if (added) {
      return FlutterIcons.close_faw;
    } else {
      return FlutterIcons.plus_faw5s;
    }
  }

  Color getButtonColor(bool color) {
    if (color) {
      return Colors.red[400];
    } else {
      return kPrimaryColor;
    }
  }
}
