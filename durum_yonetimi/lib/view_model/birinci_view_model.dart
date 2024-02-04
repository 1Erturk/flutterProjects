import 'package:durum_yonetimi/view/ikinci_sayfa.dart';
import 'package:durum_yonetimi/view_model/ikinci_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirinciViewModel with ChangeNotifier {
  String _yazi = "Merhaba";

  String get yazi => _yazi;

  set yazi(String value) {
    _yazi = value;
    notifyListeners();
  }

  Color _renk = Colors.white;

  Color get renk => _renk;

  set renk(Color value) {
    _renk = value;
    notifyListeners();
  }

  void ikinciSayfayiAc(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
        create: (context) => IkinciViewModel(),
        child: Ikincisayfa(),
      );
    });
    Navigator.push(context, pageRoute);
  }

}