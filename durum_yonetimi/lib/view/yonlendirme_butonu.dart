import 'package:durum_yonetimi/view_model/birinci_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YonlendirmeButonu extends StatelessWidget {
  const YonlendirmeButonu({super.key});

  @override
  Widget build(BuildContext context) {
    BirinciViewModel viewModel = Provider.of<BirinciViewModel>(
      context,
      listen: false,
    );
    return ElevatedButton(
      child: Text("İkinci Sayfayı Aç"),
      onPressed: () {
        viewModel.ikinciSayfayiAc(context);
      },
    );
  }
}
