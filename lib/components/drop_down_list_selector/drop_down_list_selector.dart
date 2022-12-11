import 'package:flutter/material.dart';
import 'package:karemsacrifices/utils/app_colors.dart';


class DropDownListSelector extends StatefulWidget {
  final List<dynamic> dropDownList;
  final String hint;
  final dynamic value;
  final Function onChangeFunc;
  final bool elementHasDefaultMargin;

  const DropDownListSelector(
      {Key key,
      this.dropDownList,
      this.hint,
      this.value,
      this.onChangeFunc,
      this.elementHasDefaultMargin: true})
      : super(key: key);
  @override
  _DropDownListSelectorState createState() => _DropDownListSelectorState();
}

class _DropDownListSelectorState extends State<DropDownListSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        margin: widget.elementHasDefaultMargin
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08)
            : EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
               color:    Colors.grey[100],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cHintColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            iconEnabledColor: cPrimaryColor,
            iconDisabledColor: cAccentColor,
            isExpanded: true,
            hint: Text(
              widget.hint,
              style: TextStyle(
                  color: cAccentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'HelveticaNeueW23forSKY'),
            ),
            focusColor: cPrimaryColor,
            icon:  Image.asset(
            'assets/images/down.png',
            color: cAccentColor,
          ),
            style: TextStyle(
                fontSize: 14,
                color: cBlack,
                fontWeight: FontWeight.w400,
                fontFamily: 'HelveticaNeueW23forSKY'),
            items: widget.dropDownList,
            onChanged: widget.onChangeFunc,
            value: widget.value,
          ),
        ));
  }
}
