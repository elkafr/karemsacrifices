import 'package:flutter/material.dart';

class ReservationButton extends StatelessWidget {

final String btnLbl;
final Function onPressedFunction;

  const ReservationButton({Key key, this.btnLbl, this.onPressedFunction}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Builder(
              builder: (context) => RaisedButton(
                    onPressed: () {
                      onPressedFunction();
                    },
                    elevation: 500,
           
                    color: Theme.of(context).primaryColor,
                    child: Container(
                        alignment: Alignment.center,
                        child: new Text(
                          '$btnLbl',
                          style:  Theme.of(context).textTheme.button,
                        )),
                  )));
    });
  }
}