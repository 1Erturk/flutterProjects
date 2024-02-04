import 'package:flutter/material.dart';
import 'package:ulkeler/ulke.dart';

class UlkeDetaySayfasi extends StatelessWidget {
  Ulke _ulke;

  UlkeDetaySayfasi(this._ulke);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
          _ulke.name,
          style: TextStyle(color: Colors.white),
      ),

      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 32,
        ),
        _buildBayrak(context),
        SizedBox(height: 24),
        _buildUlkeIsmiText(),
        SizedBox(height: 36),
        _buildTumDetaylar(),
      ],
    );
  }

  Widget _buildTumDetaylar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        children: [
          _buildDetayRow("Ülke İsmi: ", _ulke.name),
          _buildDetayRow("Başkent: ", _ulke.capital),
          _buildDetayRow("Bölge: ", _ulke.region),
          _buildDetayRow("Nüfus: ", _ulke.population.toString()),
          _buildDetayRow("Dil: ", _ulke.language),
        ],
      ),
    );

  }

  Widget _buildBayrak(BuildContext context) {
    return Image.network(
      _ulke.flag,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildUlkeIsmiText() {
    return Text(
      _ulke.name,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDetayRow(String baslik, String detay) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            //textAlign: TextAlign.end,
          ),
        ),
        //SizedBox(width: 32),
        Expanded(
          flex: 3,
          child: Text(
            detay,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }

}
