import 'package:agen_pulsa/genosLib/JustHelper.dart';
import 'package:agen_pulsa/page/buktitransfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import '../genosLib/genToast.dart';
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

                  var status = e["status"] == 0 ? "(Menunggu)" : e["status"] == 1 ? "(Diterima)":"(Ditolak)";

                        return GenCardArtikel(
                          ontap: () {
                            if(e["bukti_pembayaran"] == null ){
                              Navigator.pushNamed(context, "buktitransfer",
                                  arguments: BuktiTransfer(
                                    id: e["id"],
                                  ));
                            }else{
                              toastShow("permintaanmu sudah diproses", context, Colors.black);
                            }

                          },
                          judul: e["produk"]["nama_produk"] + " " +status,
                          isi: e["tanggal"],
                          harga: "Harga: " + formatRupiahUseprefik(e["harga"].toString()),
                          gambar: ip + e["produk"]["gambar"],
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
    dataBarang = await req.getApi("transaksi");

    print("DATA $dataBarang");

    setState(() {});
  }
}
