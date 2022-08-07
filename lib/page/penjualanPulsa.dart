import 'package:agen_pulsa/genosLib/component/commonPadding.dart';
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

class PenjualanPage extends StatefulWidget {
  const PenjualanPage({Key? key}) : super(key: key);

  @override
  State<PenjualanPage> createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  final req = new GenRequest();
  var dataBarang;
  bool isLoaded = false;
  bool readytoHit = true;
  var nohp, nominal;
  var dataProfil;
  String saldo = "0";

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
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
                            "Penjualan",
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
                child: CommonPadding(child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextLoginField(onChanged: (val){ nohp = val;},label: "Nomor HP",),
                    SizedBox(height: 20,),
                    TextLoginField(onChanged: (val){ nominal = val;},label: "Nominal",),
                  ],
                ),
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

                  SizedBox(
                    height: 10,
                  ),
                  GenButton(
                    text: "Kirim",
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
                                      GenText("Apa anda yakin ?"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      readytoHit
                                          ? GenButton(
                                              text: "Proses Penjualan",
                                              ontap: () {
                                                prosesKeranjang(nohp, nominal);
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

  void prosesKeranjang(nohp, nominal) async {


    if (nohp == null || nominal == null) {
      toastShow("Isi nomor hp dan nominal", context, Colors.black);




    } else {
      int isaldo = int.parse(saldo);
      int inominal = int.parse(nominal);

      if(inominal > isaldo){
        toastShow("Saldo tidak cukup", context, Colors.black);
      }else{
        setState(() {
          readytoHit = false;
        });

        var dataProses = await req.postApi("penjualan", {"no_hp": nohp, "nominal": nominal});
        if (dataProses == "berhasil") {
          toastShow("Pulsa Berhasil dikirim", context, Colors.black);
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

  void getProfile() async {
    dataProfil = await req.getApi("profile");
    print("DATA $dataProfil");


    saldo = dataProfil["agen"]["saldo"].toString();

    setState(() {});
  }
}
