import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:i_flutter/controls/text_field/supports/iKeyboardType.dart';
import 'package:i_flutter/themes/iColors.dart';

class ITextField extends StatefulWidget {
  ITextField({Key? key,
    this.autofocus = false,
    this.textStyle,
    this.maxLength,
    this.enabled,
    this.keyboardType = IKeyboardType.none,
    this.maxHeight,
    this.errorText,
    this.alwaysShowErrorText = false,
    this.title,
    this.hintText,
    this.required,
    this.showCounterText = false,
    this.titleStyle = const TextStyle(
      fontWeight: FontWeight.w500,
    ),
    this.borderRadius = 4,
    this.contentPadding,
    this.opacityEnabled = 0.7
  }) : super(key: key){
    textStyle ??= TextStyle(
        color: IColors.colorTextField
    );
  }

  bool autofocus;
  TextStyle? textStyle;
  int? maxLength;
  bool? enabled;
  double opacityEnabled;
  IKeyboardType keyboardType;
  double? maxHeight;
  Color? backroundColor;
  String? errorText;
  bool alwaysShowErrorText;  // để duy trì chiều cao cố định khi có error hay ko
  bool showCounterText;
  String? title;
  String? hintText;
  bool? required;
  TextStyle titleStyle;
  double borderRadius;
  EdgeInsets? contentPadding;

  @override
  State<ITextField> createState() => _ITextField();
}

class _ITextField extends State<ITextField> {

  Widget titleView(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(widget.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: widget.titleStyle,
          ),
        ),
        if (widget.required ?? false)
          Text(' *',
            style: widget.titleStyle.copyWith(
              color: IColors.colorRequiredTextField,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled == false ? widget.opacityEnabled : 1,
      child: Container(
        constraints: widget.maxHeight == null ? null : BoxConstraints(maxHeight: widget.maxHeight!),
        child: TextFormField(
          autofocus: widget.autofocus,
          style: widget.textStyle,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType.getTextInputType(),
          inputFormatters: widget.keyboardType.getInputFormatters(),
          obscureText: widget.keyboardType.getObscureText(),
          maxLines: widget.keyboardType.getMaxLines(),
          decoration: InputDecoration(
            fillColor: widget.backroundColor,
            filled: widget.backroundColor != null,
            errorText: widget.errorText,
            helperText: widget.alwaysShowErrorText ? '' : null,
            hintText: widget.hintText,
            counterText: widget.showCounterText ? null : '',
            label: widget.title == null ? null : titleView(),
            errorBorder: OutlineInputBorder( // unfocus và error text
              borderSide: BorderSide(color: IColors.colorRequiredTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder( // focus và error text
              borderSide: BorderSide(color: IColors.colorRequiredTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            focusedBorder: OutlineInputBorder( // focus
              borderSide: BorderSide(color: IColors.colorFocusedTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: IColors.colorUnfocusTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            enabledBorder: OutlineInputBorder( // unfocus
              borderSide: BorderSide(color: IColors.colorUnfocusTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: IColors.colorUnfocusTextField),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            contentPadding: const EdgeInsets.only( left: 12, top: 12, bottom: 12,
              right: 12,
            ),
          ),
        ),
      ),
    );
  }
}