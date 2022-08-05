import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../genosLib/JustHelper.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/etc/genDimen.dart';
import '../genosLib/component/etc/genRow.dart';
import '../genosLib/component/etc/genShadow.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genColor.dart';
import '../genosLib/genText.dart';
import '../genosLib/request.dart';
import 'menuNavbar.dart';

class ProsesPage extends StatefulWidget {
  const ProsesPage({Key? key}) : super(key: key);

  @override
  State<ProsesPage> createState() => _ProsesPageState();
}

class _ProsesPageState extends State<ProsesPage> {
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
                  width: 100,
                  height: 100,
                  child: Center(
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            "assets/icons/menu_icon.png",
                            color: Colors.black87,
                          )))),
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
                  "Pesanan anda yang masih di proses",
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
                          Center(
                            child: CircularProgressIndicator(),
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
