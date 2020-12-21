import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/MODELS/CartModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';

class BillItem extends StatelessWidget {
  final CartModel data;
  final bool isMobile;
  const BillItem({
    Key key,
    this.isMobile = false,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          padding: const EdgeInsets.all(
            10.0,
          ),
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bill No. : ' + data.billNumber.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Date : ' + data.purchaseDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.buyerName,
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 6.0,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesome.rupee,
                                size: 26.0,
                              ),
                              Text(
                                data.totalPrice,
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MaterialMenuButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                      ),
                      leadingIconData: Icon(
                        FlutterIcons.eye_faw5s,
                        color: Colors.white,
                      ),
                      buttonText: this.isMobile ? '' : 'View Bill',
                      onPressed: () {
                        createPdf(data);
                      },
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    MaterialMenuButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                      ),
                      filledColor: Colors.red[400],
                      leadingIconData: Icon(
                        FlutterIcons.trash_faw5s,
                        color: Colors.white,
                      ),
                      buttonText: this.isMobile ? '' : 'Delete',
                      onPressed: () {
                        try {
                          Firestore.instance
                              .collection('Bills')
                              .document(data.id)
                              .delete();
                        } catch (e) {
                          print(e.toString());
                          showFlushBar(
                            context: context,
                            title: 'Error!',
                            message: 'Bill deletion failed...',
                            alertStyle: true,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
