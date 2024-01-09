import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }
    var value = _currencyFormat(newValue.text);

    return newValue.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length)
    );
  }

  // 100000000 => 100,000,000
  String _currencyFormat(String price) {
    try{
      var s = price.split('.');
      if (s.isNotEmpty) {
        var value = s.first.replaceAll(',', '');
        value = value.replaceAll(RegExp(r'\B(?=(\w{3})+(?!\w))'), ',');
        if (s.length > 1){
          return '$value.${s.last}';
        }else{
          return value;
        }
      }
    }catch(er){
      if (kDebugMode) {
        print(er);
      }
    }
    return price;
  }
}
