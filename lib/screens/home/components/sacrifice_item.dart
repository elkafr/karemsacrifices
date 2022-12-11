import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_repo/product_state.dart';

import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/sacrifice.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SacrificesItem extends StatelessWidget {
  final Sacrifice sacrifice;

  const SacrificesItem({Key key, this.sacrifice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productState = Provider.of<ProductState>(context);

    return GestureDetector(
      onTap: () {
        productState.setProductId(sacrifice.adsMtgerId);
        productState.setProductTitle(sacrifice.adsMtgerName);
        Navigator.pushNamed(context, '/product_screen');
      },
      child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15.00),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 1.0,
              )
            ],
            color: cWhite,
            border: Border.all(color: Color(0xff1F61301A), width: 1.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: cPrimaryColor,
                radius: 35,
                backgroundImage: NetworkImage(sacrifice.adsMtgerPhoto),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  sacrifice.adsMtgerName,
                  style: TextStyle(
                      color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.00),
                    ),
                    color: cAccentColor),
                child: Text(
                  '${sacrifice.adsMtgerPrice} ${AppLocalizations.of(context).sr}',
                  style: TextStyle(
                    color: cPrimaryColor,
                    fontSize: 13,
                    fontFamily: 'HelveticaNeueW23forSKY',
                  ),
                ),
              )
            ],
          )),
    );
  }
}
