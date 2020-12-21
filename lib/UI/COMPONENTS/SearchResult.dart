import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:billbook/MODELS/ProductModel.dart';
import 'package:billbook/UI/COMPONENTS/DataLoader.dart';
import 'package:billbook/UI/COMPONENTS/SearchListItem.dart';

// ignore: must_be_immutable
class SearchResult extends StatefulWidget {
  String searchData;
  SearchResult({
    Key key,
    this.searchData,
  }) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> _data = Provider.of<List<ProductModel>>(context);
    if (_data != null) {
      _data = _data
          .where(
            (element) => element.productName.contains(widget.searchData),
          )
          .toList();
      return ListView(
        children: [
          Text(
            ' Search Results...',
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          SearchListItem(
            data: _data,
          ),
        ],
      );
    } else {
      return DataLoader();
    }
  }
}
