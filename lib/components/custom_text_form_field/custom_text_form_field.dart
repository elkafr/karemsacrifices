import 'package:flutter/material.dart';
import 'package:karemsacrifices/utils/app_colors.dart';


class CustomTextFormField extends StatefulWidget {
  final double verticalContentPadding;
  final bool enabled;
  final String initialValue;
  final String hintTxt;
  final TextInputType inputData;
  final bool isPassword;
  final Function validationFunc;
  final Function onChangedFunc;
  final bool suffixIconIsImage;
  final Widget suffix;
  final String suffixIconImagePath;
  final int maxLength;
  final int maxLines;
  final Widget prefixIcon;
  // this variable to detect icon as image
  final bool prefixIconIsImage;
  final String prefixIconImagePath;
  final bool buttonOnTextForm;
  final Widget prefix;
    final TextEditingController controller;
  CustomTextFormField(
      {this.hintTxt,
      this.verticalContentPadding,
      this.inputData,
      this.isPassword: false,
      this.validationFunc,
      this.onChangedFunc,
      this.initialValue,
      this.suffix,
      this.maxLength,
      this.prefixIconIsImage: false,
      this.suffixIconIsImage: false,
      this.prefixIconImagePath,
      this.suffixIconImagePath,
      this.enabled : true,
      this.maxLines = 1,
      this.buttonOnTextForm :false,
      this.prefix,
      this.prefixIcon,
      this.controller});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  Widget _buildTextFormField() {
    return TextFormField(
    
      controller: widget.controller,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      style:
          TextStyle(color: cBlack, fontSize: 15, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
           filled: true,
      fillColor: Colors.redAccent[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: _focusNode.hasFocus ? cPrimaryColor : cHintColor),
          ),
          focusColor: cPrimaryColor,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          suffixIcon: !widget.suffixIconIsImage
              ? widget.suffix
              : _focusNode.hasFocus
                  ? Image.asset(
                      widget.suffixIconImagePath,
                      color: cPrimaryColor,
                      height: 25,
                      width: 25,
                    )
                  : Image.asset(
                      widget.suffixIconImagePath,
                      color: Colors.grey,
                      height: 25,
                      width: 25,
                    ),
             prefix: widget.prefix,       
          prefixIcon: !widget.prefixIconIsImage
              ? widget.prefixIcon
              : _focusNode.hasFocus
                  ?  Image.asset(
                        widget.prefixIconImagePath,
                        color: cPrimaryColor,
                        height: 25,
                        width: 25,
                      )
                  
                  : Image.asset(
                      widget.prefixIconImagePath,
                      color: cAccentColor,
                      height: 25,
                      width: 25,
                    ),
          hintText: widget.hintTxt,
          errorStyle: TextStyle(fontSize: 12.0),
          hintStyle: TextStyle(
              color: _focusNode.hasFocus ? cPrimaryColor : cHintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          suffix: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  child:  Icon(
                      _obsecureText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                      color: _focusNode.hasFocus ? cPrimaryColor : cHintColor,
                      size: 20,
                    ),
                  )
              : null),
      keyboardType: widget.inputData,
      obscureText: widget.isPassword ? _obsecureText : false,
      validator: widget.validationFunc,
      onChanged: widget.onChangedFunc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
           height: 45,
          margin: EdgeInsets.symmetric(horizontal: widget.buttonOnTextForm ? 0.0 : constraints.maxWidth * 0.08),
          child: _buildTextFormField());
    });
  }
}
