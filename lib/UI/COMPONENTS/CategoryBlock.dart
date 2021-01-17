import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/MODELS/ProductModel.dart';
import 'package:billbook/UI/COMPONENTS/ProductListTile.dart';

class CategoryBlock extends StatefulWidget {
  final String categoryTitle;
  CategoryBlock({Key key, this.categoryTitle}) : super(key: key);

  @override
  _CategoryBlockState createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  bool expanded = false;
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ' ' + widget.categoryTitle,
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    child: SizedBox(
                      width: 40.0,
                      child: Icon(
                        expanded
                            ? FlutterIcons.angle_up_faw5s
                            : FlutterIcons.angle_down_faw5s,
                        color: kPrimaryColor,
                        size: 42.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              StreamProvider<List<ProductModel>>(
                create: (context) =>
                    getCategorizedProduct(widget.categoryTitle),
                child: Visibility(
                  visible: this.expanded,
                  child: ProductListTile(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
