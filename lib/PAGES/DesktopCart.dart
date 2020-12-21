import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/MODELS/CartModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';
import 'package:vinays_billbook/UI/COMPONENTS/DesktopCartItem.dart';

class DesktopCart extends StatefulWidget {
  final double pageWidth;
  DesktopCart({
    Key key,
    this.pageWidth,
  }) : super(key: key);

  @override
  _DesktopCartState createState() => _DesktopCartState();
}

class _DesktopCartState extends State<DesktopCart> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  bool progressing = false;

  @override
  void initState() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  buttonText: 'BACK',
                  leadingIconData: Icon(
                    FlutterIcons.arrow_left_faw5s,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
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
                  'Product Cart',
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
          height: MediaQuery.of(context).size.height,
          width: widget.pageWidth + 200,
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Constants.kCartProduct.length > 0
              ? ListView(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: this._nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Name',
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
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                ).then((date) {
                                  _dateController.text =
                                      DateFormat('dd-MM-yyyy').format(date);
                                });
                              },
                              child: TextFormField(
                                controller: this._dateController,
                                decoration: InputDecoration(
                                  labelText: 'Date',
                                  hintText: 'Date',
                                  filled: true,
                                  enabled: false,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kPrimaryColor,
                                      width: 2,
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 15.0,
                      ),
                      child: Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: DesktopCartItem(),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total Price : ',
                                style: TextStyle(
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                FontAwesome.rupee,
                                size: 38.0,
                              ),
                              Text(
                                getTotalPrice(),
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: progressing,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(kPrimaryColor),
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              MaterialMenuButton(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                leadingIconData: Icon(
                                  FlutterIcons.shopping_bag_faw5s,
                                  color: Colors.white,
                                  size: 28.0,
                                ),
                                buttonText: 'Confirm Purchase',
                                onPressed: () async {
                                  if (_nameController.text != '' &&
                                      _dateController.text != '') {
                                    if (!progressing) {
                                      setState(() {
                                        progressing = true;
                                      });
                                      try {
                                        List<Map<String, dynamic>> _temp =
                                            Constants.kCartProduct
                                                .map((e) => e.toCart())
                                                .toList();
                                        QuerySnapshot _queryData =
                                            await Firestore.instance
                                                .collection('Bills')
                                                .orderBy(
                                                  'billNumber',
                                                  descending: true,
                                                )
                                                .getDocuments();
                                        int _billNumber = 1000;
                                        if (_queryData != null &&
                                            _queryData.documents.length > 0) {
                                          _billNumber = _queryData.documents[0]
                                                  .data['billNumber'] +
                                              1;
                                        }

                                        CartModel _data = CartModel(
                                          billNumber: _billNumber,
                                          buyerName: _nameController.text,
                                          purchaseDate: _dateController.text,
                                          totalPrice: getTotalPrice(),
                                          products: _temp,
                                        );
                                        var _result = await Firestore.instance
                                            .collection('Bills')
                                            .add(_data.toMap());
                                        if (_result != null) {
                                          setState(() {
                                            Constants.kCartProduct.clear();
                                            Constants.kCartProductId.clear();
                                            this.progressing = false;
                                          });

                                          createPdf(_data);
                                          showFlushBar(
                                            context: context,
                                            title: 'Great Shopping!',
                                            message: 'Checkout Successfull...',
                                          );
                                        } else {
                                          setState(() {
                                            this.progressing = false;
                                          });
                                          showFlushBar(
                                            context: context,
                                            title: 'Error!',
                                            message:
                                                'Error occured during checkout, please try again...',
                                            alertStyle: true,
                                          );
                                        }
                                      } catch (e) {
                                        print(e.toString());
                                        setState(() {
                                          progressing = false;
                                        });
                                        showFlushBar(
                                          context: context,
                                          title: 'Error!',
                                          message:
                                              'Error occured during checkout, please try again...',
                                          alertStyle: true,
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 500,
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'no item in your cart!',
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  String getTotalPrice() {
    double _total = 0.0;
    Constants.kCartProduct.forEach((product) {
      double _temp =
          double.parse(product.productQty) * double.parse(product.productPrice);
      _total += _temp;
    });
    return _total.toString();
  }
}
