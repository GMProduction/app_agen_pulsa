import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/card/genCard.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/genText.dart';

class SuksesPesanPage extends StatefulWidget {
  const SuksesPesanPage({Key? key}) : super(key: key);

  @override
  State<SuksesPesanPage> createState() => _SuksesPesanPageState();
}

class _SuksesPesanPageState extends State<SuksesPesanPage> {
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

                    ),
                  ),
                  Container(
                      // height: 80,
                      child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: GenText(
                            "Pesanan Berhasil",
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
              child: Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/diproses.jpg", height: 300,),
                    GenText("Pesananmu Segera Diproses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 10,),
                    GenText("Mohon tunggu konfirmasi dari kami..."),
                  ],
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

                  GenButton(
                    text: "Kembali ke Menu Utama",
                    ontap: () {
                      Navigator.pushNamed(context, "home");
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
}
