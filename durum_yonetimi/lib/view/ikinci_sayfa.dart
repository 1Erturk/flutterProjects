import 'package:durum_yonetimi/model/siparis.dart';
import 'package:durum_yonetimi/view_model/ikinci_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ikincisayfa extends StatelessWidget {
  const Ikincisayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İkinci Sayfa"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<IkinciViewModel>(builder: (context, viewModel, child) {
      return ListView.builder(
        itemCount: viewModel.siparisler.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: viewModel.siparisler[index],
            child: _buildListItem(),
          );
        },
      );
    });
  }

  Widget _buildListItem() {
    return Consumer<Siparis>(
      builder: (context, siparis, child) {
        return ListTile(
          title: Text(siparis.baslik),
          subtitle: Text(siparis.durum),
          onTap: () {
            siparis.siparisOnayla();
          },
        );
      },
    );


  }
}
