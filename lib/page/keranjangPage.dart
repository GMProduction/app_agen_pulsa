import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genText.dart';
import '../genosLib/genToast.dart';
import '../genosLib/request.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final req = new GenRequest();
  var dataBarang;
  bool isLoaded = false;
  bool readytoHit = true;
  var keterangan = "";

  @override
  void initState() {
    // TODO: implement initState
    getDataKeranjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            "Keranjang Pesanan",
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
                  children: dataBarang == null
                      ? [Center(child: CircularProgressIndicator())]
                      : dataBarang.map<Widget>((e) {
                          return GenCardArtikel(
                            ontap: () {},
                            judul: e["barang"]["nama_barang"],
                            harga: "Stock: " + e["qty"].toString(),
                            gambar: ip + e["barang"]["foto"],
                          );
                        }).toList(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // GenText("Total Pembayaran"),
                  // GenText(
                  //   "Rp 50.000",
                  //   style: TextStyle(
                  //       color: Colors.orange,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 25),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  GenButtonOutline(
                    text: "Pesan Barang Lainya",
                    ontap: () {
                      Navigator.pushNamed(context, "home");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GenButton(
                    text: "Proses Pesanan",
                    ontap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextLoginField(
                                          label: "Masukan Keterangan",
                                          onChanged: (val) {
                                            keterangan = val;
                                          }),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      readytoHit
                                          ? GenButton(
                                              text: "Proses Pesanan",
                                              ontap: () {
                                                prosesKeranjang(keterangan);
                                              },
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getDataKeranjang() async {
    dataBarang = await req.getApi("cart");

    print("DATA $dataBarang");

    setState(() {});
  }

  void prosesKeranjang(keterangan) async {


    if (keterangan == "") {
      toastShow("Masukan keterangan", context, Colors.black);


    } else {
      setState(() {
        readytoHit = false;
      });

      var dataProses = await req.postApi("cart/checkout", {"keterangan": keterangan});
      if (dataProses == "Berhasil") {
        Navigator.pushNamed(context, "suksespesan");

      } else {
        // toastShow("Barang  gagal dimasukan keranjang", context, Colors.black);
        toastShow("Keranjang gagal di proses", context, Colors.black);

        setState(() {
          readytoHit = true;
        });

        print("DATA $dataProses");
      }
    }
  }
}
