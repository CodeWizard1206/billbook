import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String productName;
  String productCategory;
  String productPrice;
  bool added;
  String productQty;
  var timeStamp;

  ProductModel({
    this.id = '0',
    this.productName,
    this.productCategory,
    this.productPrice,
    this.added = false,
    this.timeStamp,
    this.productQty,
  });

  ProductModel copyWith({
    String id,
    String productName,
    String productCategory,
    String productPrice,
    bool added,
    String productQty,
    String timeStamp,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productCategory: productCategory ?? this.productCategory,
      productPrice: productPrice ?? this.productPrice,
      added: added ?? this.added,
      productQty: productQty ?? this.productQty,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productCategory': productCategory,
      'productPrice': productPrice,
      'timeStamp': timeStamp,
    };
  }

  Map<String, dynamic> toCart() {
    return {
      'id': id,
      'productName': productName,
      'productCategory': productCategory,
      'productQty': productQty,
      'productPrice': productPrice,
      'timeStamp': DateTime.now(),
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot doc) {
    if (doc == null) return null;

    Map<String, dynamic> map = doc.data;

    return ProductModel(
      id: doc.documentID,
      productName: map['productName'],
      productCategory: map['productCategory'],
      productPrice: map['productPrice'],
      timeStamp: map['timeStamp'],
    );
  }
}
