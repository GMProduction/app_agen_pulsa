import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import '../genosLib/request.dart';
import 'detailPage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final req = new GenRequest();
  var dataBarang;
  bool isLoaded = false;


  List pulsa = [
    {"id": 1,"nama": "paket tri Rp 200.000", "tanggal" : "2022-08-06","harga":180000, "provider": "three", "gambar" : "https://tri.co.id/image/files/20190309_turunan-super-website-desktop-ind.jpg"},
    {"id": 2,"nama": "paket tri Rp 300.000", "tanggal" : "2022-08-07","harga":270000, "provider": "three", "gambar" : "https://tri.co.id/image/files/20190309_turunan-super-website-desktop-ind.jpg"}];
  @override
  void initState() {
    // TODO: implement initState
    getDataBarang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenPage(
      appbar: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Container(
                  width: 80,
                  height: 80,
                  child: Center(
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "login");
                          },
                          child: CircleAvatar(
                            radius: 20.0,
                            child: Image.network(
                                "https://cdn0.iconfinder.com/data/icons/google-material-design-3-0/48/ic_account_circle_48px-512.png"),
                            backgroundColor: Colors.transparent,
                          )))),
              // GenText(
              //   "QR Code",
              //   style: TextStyle(color: Colors.black87, fontSize: 35),
              // )
            ]),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RowSpaceBetween(
                chilidLeft: GenText(
                  "Riwayat Pembelian",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                childRight: InkWell(
                    onTap: () {
                      //PINDAH KE HALAMAN LIHAT SEMUA ARTIKEL
                    },
                    child: GenText(
                      "",
                      style: TextStyle(color: GenColor.primaryColor),
                    )),
              ),
              SizedBox(
                height: GenDimen.afterTitle,
              ),
              Column(
                children: dataBarang == null
                    ? [Center(child: CircularProgressIndicator())]
                    : dataBarang.map<Widget>((e) {
                        return GenCardArtikel(
                          ontap: () {
                            Navigator.pushNamed(context, "detail",
                                arguments: DetailPage(
                                  id: e["id"],
                                  foto: ip + e["gambar"],
                                  // foto: e["gambar"],
                                  nama: e["nama_produk"],
                                  qty: e["harga"],
                                ));
                          },
                          judul: e["nama_produk"],
                          isi: e["tanggal"],
                          harga: "Harga: " + e["harga"].toString(),
                          gambar: ip + e["gambar"],
                          // gambar: e["gambar"],
                        );
                      }).toList(),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDataBarang() async {
    dataBarang = await req.getApi("transaksi/history");

    print("DATA $dataBarang");

    setState(() {});
  }
}
