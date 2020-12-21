import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinays_billbook/MODELS/CartModel.dart';
import 'package:vinays_billbook/MODELS/ProductModel.dart';

Stream<List<String>> getCategories() {
  var _data = Firestore.instance.collection('Categories').snapshots().map(
      (snapshot) => snapshot.documents
          .map((doc) => doc.data['name'].toString())
          .toList());
  return _data;
}

Future<List<Map<String, dynamic>>> getCategoryList() async {
  QuerySnapshot _snap =
      await Firestore.instance.collection('Categories').getDocuments();
  List<Map<String, dynamic>> _data = [];
  _snap.documents.forEach((doc) {
    _data.add(
      {
        'id': doc.documentID,
        'name': doc.data['name'],
      },
    );
  });
  return _data;
}

bool deleteCategory(String docID) {
  try {
    Firestore.instance.collection('Categories').document(docID).delete();
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Stream<List<ProductModel>> getCategorizedProduct(String category) {
  var _data = Firestore.instance
      .collection('Products')
      .where("productCategory", isEqualTo: category)
      .snapshots()
      .map((snapshot) =>
          snapshot.documents.map((doc) => ProductModel.fromMap(doc)).toList());
  return _data;
}

Future<List<ProductModel>> getProductList() async {
  QuerySnapshot _snap =
      await Firestore.instance.collection('Products').getDocuments();
  List<ProductModel> _data = [];
  _snap.documents.forEach((doc) {
    _data.add(
      ProductModel.fromMap(doc),
    );
  });
  return _data;
}

Stream<List<ProductModel>> getSearchResult() {
  var _data = Firestore.instance
      .collection('Products')
      .snapshots()
      .map((snap) => snap.documents
          .map(
            (doc) => ProductModel.fromMap(doc),
          )
          .toList());

  return _data;
}

bool deleteProduct(String docID) {
  try {
    Firestore.instance.collection('Products').document(docID).delete();
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Stream<List<CartModel>> getBills() {
  var _data = Firestore.instance
      .collection('Bills')
      .orderBy(
        'billNumber',
        descending: true,
      )
      .snapshots()
      .map((snapshot) =>
          snapshot.documents.map((doc) => CartModel.fromMap(doc)).toList());
  return _data;
}
