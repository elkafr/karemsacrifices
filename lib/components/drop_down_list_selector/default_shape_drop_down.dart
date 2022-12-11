import 'package:flutter/material.dart';
import 'package:karemsacrifices/utils/app_colors.dart';


class DefaultShapeOfDropDown extends StatelessWidget {
  final bool elementHasDefaultMargin;
  final String hint;

  const DefaultShapeOfDropDown(
      {Key key, this.elementHasDefaultMargin: true, this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      margin: elementHasDefaultMargin
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08)
          : EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
    color:    Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cHintColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            hint,
            style: TextStyle(
                color: cAccentColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'HelveticaNeueW23forSKY'),
          ),
          Image.asset(
            'assets/images/down.png',
            color: cAccentColor,
          ),
        ],
      ),
    );
  }
}
