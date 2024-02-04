import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler/ulke.dart';
import 'package:ulkeler/ulkeDetaySayfasi.dart';

class OrtakListe extends StatefulWidget {
  List<Ulke> _ulkeler = [];

  List<String> _favoriUlkeKodlari = [];

  OrtakListe(this._ulkeler, this._favoriUlkeKodlari);

  @override
  State<OrtakListe> createState() => _OrtakListeState();
}

class _OrtakListeState extends State<OrtakListe> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._ulkeler.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Ulke ulke = widget._ulkeler[index];

    return Card(
      child: ListTile(
        title: Text(ulke.name),
        subtitle: Text("Başkent: ${ulke.capital}"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(ulke.flag),
        ),
        trailing: IconButton(
          icon: Icon(
            widget._favoriUlkeKodlari.contains(ulke.countryCode)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            _favoriTiklandi(ulke);
          },
        ),
        onTap: (){
          _ulkeTiklandi(context, ulke);
        },
      ),
    );
  }

  void _ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(builder: (context) {
      return UlkeDetaySayfasi(ulke);
    });
    Navigator.push(context, sayfaYolu);
  }

  void _favoriTiklandi(Ulke ulke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(widget._favoriUlkeKodlari.contains(ulke.countryCode)) {
      widget._favoriUlkeKodlari.remove(ulke.countryCode);
    } else {
      widget._favoriUlkeKodlari.add(ulke.countryCode);
    }

    await prefs.setStringList("favoriler", widget._favoriUlkeKodlari);
    setState(() {});
  }
}
