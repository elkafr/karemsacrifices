import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final Color btnColor;
  final Color borderColor;
  final String btnLbl;
  final Function onPressedFunction;
  final TextStyle btnStyle;
  final bool buttonOnDialog;

  const CustomButton(
      {Key key,
      this.btnLbl,
      this.height,
      this.onPressedFunction,
      this.borderColor,
      this.btnColor,
      this.btnStyle,
      this.buttonOnDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:  height != null ? height : 45,
        margin: EdgeInsets.symmetric(
            horizontal:
                buttonOnDialog ? 0.0 : MediaQuery.of(context).size.width * 0.08,
            vertical: 5),
        child: Builder(
            builder: (context) => RaisedButton(
                  onPressed: () {
                    onPressedFunction();
                  },
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: borderColor != null
                      ? borderColor
                      : Theme.of(context).primaryColor,)
                    ),
                  color: btnColor != null
                      ? btnColor
                      : Theme.of(context).primaryColor,
                  child: Container(
                      alignment: Alignment.center,
                      child: new Text(
                        '$btnLbl',
                        style: btnStyle == null
                            ? Theme.of(context).textTheme.button
                            : btnStyle,
                      )),
                )));
  }
}
