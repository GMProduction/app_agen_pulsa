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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final req = new GenRequest();
  var dataBarang;
  bool isLoaded = false;


  List pulsa = [
    {"id": 1,"nama": "paket tri Rp 200.000", "harga":180000, "provider": "three", "gambar" : "https://tri.co.id/image/files/20190309_turunan-super-website-desktop-ind.jpg"},
    {"id": 2,"nama": "paket tri Rp 300.000", "harga":270000, "provider": "three", "gambar" : "https://tri.co.id/image/files/20190309_turunan-super-website-desktop-ind.jpg"}];
  @override
  void initState() {
    // TODO: implement initState
    // getDataBarang();
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
                            // Navigator.pushNamed(context, "login");
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
                  "Barang yang tersedia",
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
                children: pulsa == null
                    ? [Center(child: CircularProgressIndicator())]
                    : pulsa.map<Widget>((e) {
                        return GenCardArtikel(
                          ontap: () {
                            Navigator.pushNamed(context, "detail",
                                arguments: DetailPage(
                                  id: e["id"],
                                  // foto: ip + e["gambar"],
                                  foto: e["gambar"],
                                  nama: e["nama"],
                                  qty: e["harga"],
                                ));
                          },
                          judul: e["nama"],
                          harga: "Harga: " + e["harga"].toString(),
                          // gambar: ip + e["gambar"],
                          gambar: e["gambar"],
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

  // void getDataBarang() async {
  //   dataBarang = await req.getApi("barangs");
  //
  //   print("DATA $dataBarang");
  //
  //   setState(() {});
  // }
}
