import 'package:flutter/material.dart';
import 'package:billbook/Constants.dart';

class DesktopCartItem extends StatelessWidget {
  const DesktopCartItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Constants.kCartProduct
          .map(
            (product) => Padding(
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
                      initialValue: product.productQty,
                      decoration: InputDecoration(
                        hintText: 'Qty',
                        filled: true,
                        enabled: false,
                        disabledBorder: UnderlineInputBorder(
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
                      initialValue: product.productPrice,
                      decoration: InputDecoration(
                        hintText: 'Price',
                        filled: true,
                        enabled: false,
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
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
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
