import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/model/kitap.dart';

class YerelVeriTabani {
  YerelVeriTabani._privateConstructor();

  static final YerelVeriTabani _nesne = YerelVeriTabani._privateConstructor();

  factory YerelVeriTabani() {
    return _nesne;
  }

  Database? _veriTabani;

  String _kitaplarTabloAdi = "kitaplar";
  String _idKitaplar = "id";
  String _isimKitaplar = "isim";
  String _olusturulmaTarihiKitaplar = "olusturulmaTarihi";
  String _kategoriKitaplar = "kategori";

  String _bolumlerTabloAdi = "bolumler";
  String _idBolumler = "id";
  String _kitapIdBolumler = "kitapId";
  String _baslikBolumler = "baslik";
  String _icerikBolumler = "icerik";
  String _olusturulmaTarihiBolumler = "olusturulmaTarihi";



  Future<Database?> _veriTabaniniGetir() async {
    if(_veriTabani == null) {
      String dosyaYolu = await getDatabasesPath();
      String veriTabaniYolu = join(dosyaYolu, "yazar.db");
      _veriTabani = await openDatabase(
        veriTabaniYolu,
        version: 2,
        onCreate: _tabloOlustur,
        onUpgrade: _tabloGuncelle,
      );
    }
    return _veriTabani;
  }

  Future<void> _tabloOlustur(Database db, int versiyon) async {
    await db.execute(
      """
      CREATE TABLE $_kitaplarTabloAdi (
        $_idKitaplar INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
        $_isimKitaplar TEXT NOT NULL,
        $_olusturulmaTarihiKitaplar INTEGER,
        $_kategoriKitaplar INTEGER DEFAULT 0
      );    
      """
    );
    await db.execute(
        """
      CREATE TABLE $_bolumlerTabloAdi (
        $_idBolumler INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
        $_kitapIdBolumler INTEGER NOT NULL,
        $_baslikBolumler TEXT NOT NULL,
        $_icerikBolumler TEXT,
        $_olusturulmaTarihiKitaplar TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY("$_kitapIdBolumler") REFERENCES "$_kitaplarTabloAdi"("$_idKitaplar") ON UPDATE CASCADE ON DELETE CASCADE
      );    
      """
    );
  }

  FutureOr<void> _tabloGuncelle(Database db, int oldVersion, int newVersion) async {
    List<String> guncellemeKomutlari = [
      "ALTER TABLE $_kitaplarTabloAdi ADD COLUMN $_kategoriKitaplar INTEGER DEFAULT 0",
      "ALTER TABLE $_kitaplarTabloAdi ADD COLUMN test INTEGER DEFAULT 0"
    ];

    for(int i = oldVersion - 1; i < newVersion - 1; i++) {
      await db.execute(guncellemeKomutlari[i]);
    }

  }


  //CRUD
  // Create, Read, Update, Delete

  Future<int> createKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.insert(_kitaplarTabloAdi, kitapToMap(kitap));
    } else {
      return -1;
    }
  }

  Future<List<Kitap>> readTumKitaplar(int kategoriId, int sonKitapId) async {
    Database? db = await _veriTabaniniGetir();
    List<Kitap> kitaplar = [];

    if(db != null) {
      String filtre = "$_idKitaplar > ?";
      List<dynamic> filtreArgumanlari = [sonKitapId];
      
      if(kategoriId >= 0) {
        filtre += " and $_kategoriKitaplar = ?";
        filtreArgumanlari.add(kategoriId);
      }
      
      List<Map<String, dynamic>> kitaplarMap = await db.query(
        _kitaplarTabloAdi,
        where: filtre,
        whereArgs: filtreArgumanlari,
        //orderBy: "$_kategoriKitaplar desc, $_isimKitaplar asc",
        //orderBy: "$_isimKitaplar collate localized",
        orderBy: "$_idKitaplar",
        //limit: 3,
        //offset: 2,
        limit: 15,
      );
      for(Map<String, dynamic> m in kitaplarMap) {
        Kitap k = _mapToKitap(m);
        kitaplar.add(k);
      }
    }

    return kitaplar;
  }

  Future<int> updateKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.update(
        _kitaplarTabloAdi,
        kitapToMap(kitap),
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> deleteKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.delete(
        _kitaplarTabloAdi,
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> deleteKitaplar(List<int> kitapIdleri) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null && kitapIdleri.isNotEmpty) {
        String filtre = "$_idKitaplar in (";

        for(int i = 0; i < kitapIdleri.length; i++) {
          if(i != kitapIdleri.length - 1) {
            filtre += "?,";
          } else {
            filtre += "?)";
          }
        }

      return await db.delete(
        _kitaplarTabloAdi,
        where: filtre,
        whereArgs: kitapIdleri,
      );
    } else {
      return 0;
    }
  }

  Future<int> createBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.insert(_bolumlerTabloAdi, bolum.toMap());
    } else {
      return -1;
    }
  }

  Future<List<Bolum>> readTumBolumler(int kitapId) async {
    Database? db = await _veriTabaniniGetir();
    List<Bolum> bolumler = [];

    if(db != null) {
      List<Map<String, dynamic>> bolumlerMap = await db.query(
        _bolumlerTabloAdi,
        where: "$_kitapIdBolumler = ?",
        whereArgs: [kitapId],
      );
      for(Map<String, dynamic> m in bolumlerMap) {
        Bolum b = Bolum.fromMap(m);
        bolumler.add(b);
      }
    }

    return bolumler;
  }

  Future<int> updateBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.update(
        _bolumlerTabloAdi,
        bolum.toMap(),
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> deleteBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db != null) {
      return await db.delete(
        _bolumlerTabloAdi,
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    } else {
      return 0;
    }
  }

  Map<String, dynamic> kitapToMap(Kitap kitap) {
    Map<String, dynamic> kitapMap = kitap.toMap();
    DateTime? olusturulmaTarihi = kitapMap["olusturulmaTarihi"];
    if(olusturulmaTarihi != null) {
      kitapMap["olusturulmaTarihi"] = olusturulmaTarihi.millisecondsSinceEpoch;
    }
    return kitapMap;
  }

  Kitap _mapToKitap(Map<String, dynamic> m) {
    Map<String, dynamic> kitapMap = Map.from(m);
    int? olusturulmaTarihi = kitapMap["olusturulmaTarihi"];
    if(olusturulmaTarihi != null) {
      kitapMap["olusturulmaTarihi"] = DateTime.fromMillisecondsSinceEpoch(
        olusturulmaTarihi,
      );
    }
    return Kitap.fromMap(kitapMap);
  }

}

