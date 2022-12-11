import 'dart:async';

import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_repo/product_state.dart';
import 'package:karemsacrifices/components/buttons/custom_button.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationDialog extends StatefulWidget {
  final double lng;
  final double lat;
  final String address;

  const LocationDialog({Key key, this.lng, this.lat, this.address}) : super(key: key);


  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
    Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _marker = Set();

  @override
  Widget build(BuildContext context) {
      _marker.add(Marker(
        markerId: MarkerId('my marker'),
        infoWindow: InfoWindow(title: widget.address),
        position: LatLng(widget.lat, widget.lng),
        flat: true));
    return  LayoutBuilder(builder: (context,constraints){
 return AlertDialog(
   contentPadding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SingleChildScrollView(
        child:  Column(
        
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
      
             Container(
                decoration: BoxDecoration(
                     color: cAccentColor,
                        borderRadius: BorderRadius.only(
                          topLeft:  Radius.circular(15.00),
                          topRight:  Radius.circular(15.00),
                        ),
                        border: Border.all(color: cAccentColor)),
               alignment: Alignment.center,
               width: MediaQuery.of(context).size.width,
               height: 40,
            
               child: Text(AppLocalizations.of(context).detectYourLocation,style: TextStyle(
                 color: cBlack,fontSize: 16,
                 fontWeight: FontWeight.w700
               ),),
             ),
             Container(
               height: 200,
               child:  GoogleMap(
        markers: _marker,
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat,
                widget.lng),
            zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
             ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Text(widget.address,style: TextStyle(
                height: 1.5,
               color: Color(0xffB7B7B7),fontSize: 11,fontWeight: FontWeight.w400
             )),
            ),
              Container(
              margin: EdgeInsets.only( bottom: 20, right: 15, left: 15),
              child: CustomButton(
                  height: 35,
                  buttonOnDialog: true,
                  btnLbl: AppLocalizations.of(context).confirmLocation,
                  onPressedFunction: () async {
                    Navigator.pop(context);
                  }))
             
          ],
        )),
      
    );
    });
  }
}
