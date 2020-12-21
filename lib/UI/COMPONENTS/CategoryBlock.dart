import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinays_billbook/DatabaseHandler.dart';
import 'package:vinays_billbook/MODELS/ProductModel.dart';
import 'package:vinays_billbook/UI/COMPONENTS/ProductListTile.dart';

class CategoryBlock extends StatefulWidget {
  final String categoryTitle;
  CategoryBlock({Key key, this.categoryTitle}) : super(key: key);

  @override
  _CategoryBlockState createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ' + widget.categoryTitle,
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              StreamProvider<List<ProductModel>>(
                create: (context) =>
                    getCategorizedProduct(widget.categoryTitle),
                child: ProductListTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
