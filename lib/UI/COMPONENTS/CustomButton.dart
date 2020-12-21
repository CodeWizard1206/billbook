import 'package:flutter/material.dart';
import 'package:vinays_billbook/Constants.dart';

class MaterialMenuButton extends StatelessWidget {
  final String buttonText;
  final Icon leadingIconData;
  final Function onPressed;
  final EdgeInsets padding;
  final Color filledColor;
  final double elevation;
  final TextStyle style;
  const MaterialMenuButton({
    Key key,
    this.buttonText,
    this.leadingIconData,
    this.onPressed,
    this.style = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.elevation = 5.0,
    this.filledColor = kPrimaryColor,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: this.elevation,
      onPressed: this.onPressed,
      constraints: BoxConstraints(
        minWidth: 50.0,
        minHeight: 54.0,
      ),
      fillColor: this.filledColor,
      child: Padding(
        padding: this.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.leadingIconData,
            Visibility(
              visible: (this.buttonText != ''),
              child: SizedBox(
                width: 4.0,
              ),
            ),
            Visibility(
              visible: (this.buttonText != ''),
              child: Text(
                this.buttonText,
                style: this.style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
