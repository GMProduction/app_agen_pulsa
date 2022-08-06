import 'package:agen_pulsa/genosLib/component/commonPadding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../genosLib/JustHelper.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import '../genosLib/request.dart';

class Penjualan extends StatefulWidget {
  const Penjualan({Key? key}) : super(key: key);

  @override
  State<Penjualan> createState() => _PenjualanState();
}

class _PenjualanState extends State<Penjualan> {
  final req = new GenRequest();
  List? dataTransaksi;

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    getDataTransaksi();
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
                            // Navigator.of(context).pop();
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
                  "Riwayat Penjualan",
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
                  children: dataTransaksi == null
                      ? [
                    CommonPadding(
                      child: GenCard(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GenText("Tanggal : 6 Agustus 2022"),
                            SizedBox(height: 5,),
                            GenText("Nomor hp : 08715487415"),
                            SizedBox(height: 5,),
                            GenText("Nominal : Rp 50.000"),
                          ],
                        ),
                      ),
                    )
                  ]
                      : dataTransaksi!.map<Widget>((e) {
                          return GenCardOrder(
                            isi: e["keranjang"]["cart"],
                            nomor: e["id"].toString(),
                            tanggal: e["tanggal"],
                            status: statusTrans(e["status"]),
                            ontap: () {
                              Navigator.pushNamed(context, "detail");
                            },
                          );
                        }).toList()),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDataTransaksi() async {
    var data = await req.getApi("transaction");
    print("DATA tra $dataTransaksi");
    dataTransaksi = [];

    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        Map mapdata = data[i];
        var dataKeranjang =
            await req.getApi("transaction/" + mapdata["id"].toString());
        mapdata["keranjang"] = dataKeranjang;

        dataTransaksi!.add(mapdata);
      }
    }

    var logger = Logger();
    logger.i("DATA LOG " + dataTransaksi![0]["keranjang"].toString());
    setState(() {});
  }
}
