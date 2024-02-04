import 'package:flutter/material.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class BolumDetayViewModel with ChangeNotifier{
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  final Bolum _bolum;

  Bolum get bolum => _bolum;

  BolumDetayViewModel(this._bolum);

  void icerigiKaydet(String icerik) async {
    _bolum.icerik = icerik;
    await _yerelVeriTabani.updateBolum(_bolum);
  }
}