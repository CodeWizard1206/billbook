import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String id;
  int billNumber;
  String buyerName;
  String purchaseDate;
  String totalPrice;
  List<dynamic> products;

  CartModel({
    this.id = '0',
    this.billNumber,
    this.buyerName,
    this.purchaseDate,
    this.totalPrice,
    this.products,
  });

  CartModel copyWith({
    String id,
    int billNumber,
    String buyerName,
    String purchaseDate,
    String totalPrice,
    List<dynamic> products,
  }) {
    return CartModel(
      id: id ?? this.id,
      billNumber: billNumber ?? this.billNumber,
      buyerName: buyerName ?? this.buyerName,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      totalPrice: totalPrice ?? this.totalPrice,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'billNumber': billNumber,
      'buyerName': buyerName,
      'purchaseDate': purchaseDate,
      'totalPrice': totalPrice,
      'products': products,
    };
  }

  factory CartModel.fromMap(DocumentSnapshot doc) {
    if (doc == null) return null;

    Map<String, dynamic> map = doc.data;

    return CartModel(
      id: doc.documentID,
      billNumber: map['billNumber'],
      buyerName: map['buyerName'],
      purchaseDate: map['purchaseDate'],
      totalPrice: map['totalPrice'],
      products: map['products'],
    );
  }
}
