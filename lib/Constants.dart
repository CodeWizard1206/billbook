import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:billbook/MODELS/CartModel.dart';
import 'package:billbook/MODELS/ProductModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const Color kPrimaryColor = Color(0xff2196f3);
const Color kPrimaryDarkColor = Color(0xFF373435);

void createPdf(CartModel _data) {
  var pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      orientation: pw.PageOrientation.portrait,
      margin: const pw.EdgeInsets.all(30.0),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'CUSTOMER RECEIPT',
              style: pw.TextStyle(
                fontSize: 20.0,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Bill Number : ' + _data.billNumber.toString(),
                  style: pw.TextStyle(
                    fontSize: 16.0,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Purchase Date : ' + _data.purchaseDate,
                  style: pw.TextStyle(
                    fontSize: 16.0,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              width: double.maxFinite,
              child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: pw.Text(
                  _data.buyerName,
                  style: pw.TextStyle(
                    fontSize: 18.0,
                    fontWeight: pw.FontWeight.bold,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ),
            ),
            pw.Container(
              height: 680,
              // width: double.maxFinite,
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      height: double.maxFinite,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                      child: pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Row(
                            mainAxisSize: pw.MainAxisSize.min,
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: getHeading('Sr. No.'),
                              ),
                              pw.Expanded(
                                flex: 8,
                                child: getHeading('Products'),
                              ),
                              pw.Expanded(
                                flex: 1,
                                child: getHeading('Qty'),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: getHeading('Rate'),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 5.0,
                          ),
                          pw.Column(
                            mainAxisSize: pw.MainAxisSize.min,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: getBillItemList(_data.products),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    height: 15.0,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Total Amount : ',
                        style: pw.TextStyle(
                          fontSize: 17.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Rs. ' + _data.totalPrice,
                        style: pw.TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  List<int> bytes = pdf.save();

  AnchorElement(
      href:
          'data:application/octetstream;charset=utf-16le;base64,${base64.encode(bytes)}')
    ..setAttribute('download', _data.id + '.pdf')
    ..click();
}

pw.Container getHeading(String title) {
  return pw.Container(
    height: 40,
    width: double.maxFinite,
    padding: const pw.EdgeInsets.symmetric(
      horizontal: 3.0,
    ),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(
        color: PdfColors.black,
        width: 1,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ),
  );
}

pw.Container getRowData(String text) {
  return pw.Container(
    width: double.maxFinite,
    padding: const pw.EdgeInsets.symmetric(
      horizontal: 6.0,
    ),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 13,
        fontStyle: pw.FontStyle.italic,
      ),
    ),
  );
}

List<pw.Padding> getBillItemList(List<dynamic> _data) {
  int i = 0;
  return _data.map((map) {
    i++;
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        vertical: 3.0,
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Expanded(
            flex: 1,
            child: getRowData(i.toString()),
          ),
          pw.Expanded(
            flex: 8,
            child: getRowData(map['productName']),
          ),
          pw.Expanded(
            flex: 1,
            child: getRowData(map['productQty']),
          ),
          pw.Expanded(
            flex: 2,
            child: getRowData(map['productPrice']),
          ),
        ],
      ),
    );
  }).toList();
}

void showFlushBar(
    {String title,
    BuildContext context,
    bool alertStyle = false,
    String message = 'Please wait for sometime or Try again '}) {
  Flushbar(
    maxWidth: 500.0,
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.all(15.0),
    borderRadius: 8.0,
    backgroundGradient: LinearGradient(
      colors: alertStyle
          ? [Colors.red[600], Colors.redAccent[400]]
          : [Colors.green[600], Colors.greenAccent[400]],
      stops: [0.4, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 4,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: message,
    duration: Duration(seconds: 5),
  )..show(context);
}

class Constants {
  static List<ProductModel> kCartProduct = [];
  static List<String> kCartProductId = [];
  static bool isLoggedIn = false;
}
