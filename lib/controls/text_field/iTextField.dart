
import 'package:flutter/material.dart';
import 'package:i_flutter/controls/text_field/supports/iKeyboardType.dart';
import 'package:i_flutter/themes/iColors.dart';

enum IconAlignment{
  top, center, bottom;

  Alignment getAlignment(){
    switch(this){
      case IconAlignment.top:
        return Alignment.topRight;
      case IconAlignment.center:
        return Alignment.centerRight;
      case IconAlignment.bottom:
        return Alignment.bottomRight;
    }
  }
}

class ITextField extends StatefulWidget {
  ITextField({Key? key,
    this.controller,
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
    this.opacityEnabled = 0.7,
    this.iconAlignment = IconAlignment.top,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key){
    controller ??= TextEditingController();
    textStyle ??= TextStyle(
        color: IColors.colorTextField
    );
  }

  /// tự động mở bàn phím khi khởi tạo
  bool autofocus;

  /// style text field
  TextStyle? textStyle;

  /// giới hạn ký tự
  int? maxLength;

  /// cho phép tương tác với text field
  bool? enabled;

  /// độ mờ thi text field disable
  double opacityEnabled;

  /// loại bàn phím
  IKeyboardType keyboardType;

  /// chiều cao tối đa khi text field multiline co dãng
  double? maxHeight;

  /// màu backround text field
  Color? backroundColor;

  /// text thông báo lỗi
  String? errorText;

  /// để duy trì chiều cao cố định khi có error hay không
  bool alwaysShowErrorText;

  /// hiện text đếm số lượng ký tự
  bool showCounterText;

  /// title text field
  String? title;

  /// nội dung gợi ý text nhập
  String? hintText;

  /// hiện *
  bool? required;

  /// style title text field
  TextStyle titleStyle;

  /// độ cong của border text field
  double borderRadius;

  /// padding nội dung
  EdgeInsets? contentPadding;

  /// vị trí icon
  IconAlignment iconAlignment;

  /// icon bên trái
  Widget? prefixIcon;

  /// icon bên phải
  Widget? suffixIcon;

  TextEditingController? controller;
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
    var icon = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          constraints: const BoxConstraints(),
          icon: Icon(Icons.close, color: IColors.colorTextField.withOpacity(0.6)),
          onPressed: () {
            widget.controller?.clear();
          },
        ),
        if(widget.suffixIcon != null)
          widget.suffixIcon ?? const SizedBox(),
      ],
    );
    return Opacity(
      opacity: widget.enabled == false ? widget.opacityEnabled : 1,
      child: Container(
        constraints: widget.maxHeight == null ? null : BoxConstraints(maxHeight: widget.maxHeight!),
        child: Stack(
          alignment: widget.iconAlignment.getAlignment(),
          children: [
            TextFormField(
              controller: widget.controller,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                prefixIconConstraints: const BoxConstraints(minWidth: 12),
                suffixIconConstraints: const BoxConstraints(minWidth: 12,),
                prefixIcon: widget.prefixIcon ?? const SizedBox(),
                suffixIcon: Opacity(opacity: 0, child: IgnorePointer(child: icon)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: icon,
            )
          ],
        ),
      ),
    );
  }
}