import 'package:durum_yonetimi/checkbox_provider.dart';
import 'package:durum_yonetimi/view/yonlendirme_butonu.dart';
import 'package:durum_yonetimi/view_model/birinci_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirinciSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BirinciViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: viewModel.renk,
          appBar: AppBar(
            title: Text("Birinci Sayfa"),
          ),
          body: child,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlutterLogo(size: 96),
          _buildBaslik(),
          _buildYaziyiDegistirButton(context),
          _buildRenkDegistirButton(context),
          YonlendirmeButonu(),
          _buildCheckboxRow(context),
        ],
      ),
    );
  }

  Widget _buildBaslik() {
    return Consumer<BirinciViewModel>(builder: (context, viewModel, child) {
      return Text(
        viewModel.yazi,
        style: TextStyle(fontSize: 28),
      );
    });
  }

  Widget _buildYaziyiDegistirButton(BuildContext context) {
    BirinciViewModel viewModel = Provider.of<BirinciViewModel>(
      context,
      listen: false,
    );
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Yazıyı Değiştir"),
        onPressed: () {
          viewModel.yazi = "Butona Tıklandı";
        },
      ),
    );
  }

  Widget _buildRenkDegistirButton(BuildContext context) {
    BirinciViewModel viewModel = Provider.of<BirinciViewModel>(
      context,
      listen: false,
    );
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Rengi Değiştir"),
        onPressed: () {
          viewModel.renk = Colors.blue;
        },
      ),
    );
  }


  Widget _buildCheckboxRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ("Checkbox:"),
          style: TextStyle(fontSize: 18),
        ),
        Consumer<CheckboxProvider>(builder: (context, viewModel, child) {
          return Checkbox(
            value: viewModel.checkboxSeciliMi,
            onChanged: (bool? yeniDeger) {
              if (yeniDeger != null) {
                viewModel.checkboxSeciliMi = yeniDeger;
              }
            },
          );
        }),
      ],
    );
  }
}
