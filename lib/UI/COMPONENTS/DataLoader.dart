import 'package:flutter/material.dart';
import 'package:vinays_billbook/Constants.dart';

class DataLoader extends StatelessWidget {
  final double height, width;
  const DataLoader({Key key, this.height = 0, this.width = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          (this.height != 0) ? this.height : MediaQuery.of(context).size.height,
      width: (this.width != 0) ? this.width : MediaQuery.of(context).size.width,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kPrimaryColor),
        ),
      ),
    );
  }
}
