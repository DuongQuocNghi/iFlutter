import 'package:flutter/services.dart';
import 'package:i_flutter/controls/text_field/supports/CurrencyInputFormatter.dart';

enum IKeyboardType{
  none, currency, password, multiline;

  TextInputType? getTextInputType(){
    switch(this){
      case IKeyboardType.currency:
        return const TextInputType.numberWithOptions(decimal: true,);
      case IKeyboardType.multiline:
        return TextInputType.multiline;
      default:
        return null;
    }
  }

  List<TextInputFormatter>? getInputFormatters(){
    switch(this){
      case IKeyboardType.currency:
        return [
          CurrencyInputFormatter(),
        ];
      default:
        return null;
    }
  }

  int? getMaxLines(){
    switch(this){
      case IKeyboardType.multiline:
        return null;
      default:
        return 1;
    }
  }

  bool getObscureText(){
    switch(this){
      case IKeyboardType.password:
        return true;
      default:
        return false;
    }
  }
}