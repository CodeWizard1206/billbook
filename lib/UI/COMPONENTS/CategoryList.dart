import 'package:flutter/material.dart';
import 'package:billbook/MODELS/CategoryModel.dart';

class CategoryList extends StatefulWidget {
  final CategoryModel data;
  final Function stateChanged;
  CategoryList({
    Key key,
    this.data,
    this.stateChanged,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.data.name,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      onChanged: (bool status) {
        setState(() {
          if (status) {
            widget.data.added = status;
          } else {
            widget.data.added = status;
          }
          widget.stateChanged(status);
        });
      },
      value: widget.data.added,
    );
  }
}
