import 'package:agen_pulsa/genosLib/JustHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genText.dart';
import '../genosLib/genToast.dart';
import '../genosLib/request.dart';

class DetailPage extends StatefulWidget {

  final int? id;
  final String? nama;
  final String? foto;
  final int? qty;
  DetailPage({this.id, this.nama, this.foto, this.qty});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final req = new GenRequest();
  var dataBarang, id, nama, foto, stock;
  bool readytoHit = true;
  int qty = 1;


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as DetailPage;
    id = args.id;
    nama = args.nama;
    foto = args.foto;
    stock = args.qty;

    print("ID DETAIL "+ id.toString());
    return GenPage(
      appbar: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ))),
                  ),
                  Container(
                      // height: 80,
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: GenText(
                            "Detail Barang",
                            style: TextStyle(fontSize: 20),
                          ))),
                  // GenText(
                  //   "QR Code",
                  //   style: TextStyle(color: Colors.black87, fontSize: 35),
                  // )
                ]),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        foto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GenText(
                              nama,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            GenText(
                              "Harga : "+formatRupiahUseprefik(stock.toString()),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // TextLoginField(label: "Catatan")
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  readytoHit ? GenButton(
                    text: "Beli Sekarang",
                    ontap: () {
                      postDataBarang(id, stock);
                      // Navigator.pushNamed(context, "buktitransfer");
                    },
                  ) : Center(child: CircularProgressIndicator(),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void postDataBarang(barangid, harga) async {
    setState(() {
      readytoHit = false;
    });


      dataBarang = await req.postApi("transaksi", {"produk_id": barangid, "harga": harga});
      if(dataBarang == "berhasil"){
        print("data berhasil : "+dataBarang.toString());
        toastShow("produk berhasil dibeli, silahkan masukan pembayaran", context, Colors.black);
        Navigator.pushReplacementNamed(context, "history");
      }else{
        toastShow("produk tidak bisa dibeli, silahkan hubungi admin", context, Colors.black);
        setState(() {
          readytoHit = true;
        });

      print("DATA $dataBarang");
    }
  }
}
