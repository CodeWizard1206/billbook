import 'package:flutter/material.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/MODELS/ProductModel.dart';

class MobileCartItem extends StatelessWidget {
  MobileCartItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Constants.kCartProduct
          .map(
            (product) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          product.productName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: product.productQty,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Qty',
                            filled: true,
                            enabled: false,
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
                        width: 40.0,
                        child: Text(
                          'X',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: product.productPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            filled: true,
                            enabled: false,
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
                      Text(
                        getItemRate(product),
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  String getItemRate(ProductModel product) {
    double _qty = double.parse(product.productQty);
    double _price = double.parse(product.productPrice);

    double _returnable = _qty * _price;

    return _returnable.toStringAsFixed(2);
  }
}
