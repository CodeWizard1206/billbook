import 'package:flutter/material.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CategoryBlock.dart';

class CategorizedProductList extends StatelessWidget {
  final List<String> categoryData;
  const CategorizedProductList({
    Key key,
    this.categoryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: categoryData
          .map(
            (category) => Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: CategoryBlock(categoryTitle: category),
            ),
          )
          .toList(),
    );
  }
}
