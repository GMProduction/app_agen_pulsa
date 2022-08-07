
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../genosLib/component/button/genButton.dart';
import '../genosLib/component/commonPadding.dart';
import '../genosLib/component/page/genPage.dart';
import '../genosLib/component/textfiled/TextField.dart';
import '../genosLib/genText.dart';
import '../genosLib/genToast.dart';
import '../genosLib/request.dart';

class BuktiTransfer extends StatefulWidget {
  int? id;
  BuktiTransfer({this.id});

  @override
  State<BuktiTransfer> createState() => _BuktiTransferState();
}

class _BuktiTransferState extends State<BuktiTransfer> {

  XFile? _image;
  final _picker = ImagePicker();

  var readyToHit = true;

  Future<XFile?> pickImage() async {
    final _picker = ImagePicker();

    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print('PickedFile: ${pickedFile.toString()}');
      setState(() {
        _image = XFile(pickedFile.path); // Exception occurred here
      });
    } else {
      print('PickedFile: is null');
    }

    if (_image != null) {
      return _image!;
    }
    return null;
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      // for (final XFile file in response.files) {
      //   // _handleFile(file);
      // }
    } else {
      // _handleError(response.exception);
    }
  }


  final req = new GenRequest();
  var dataBukti, deskripsi;
  bool loaded = false;
  var id;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as BuktiTransfer;
    id = args.id;

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
                            "Masukan Keluhan",
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
                    SizedBox(
                      height: 50,
                    ),
                    CommonPadding(
                      child: Row(
                        children: [

                          FloatingActionButton(
                            mini: true,
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              pickImage();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GenText(
                            "Masukan Bukti Transfer",
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _image == null
                        ? Center(
                          child: Container(
                      width: 0,
                      height: 0,
                    ),
                        )
                        : Center(
                          child: Image.file(
                      File(_image!.path),
                      width: 300,
                      fit: BoxFit.fitWidth,
                    ),
                        ),

                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [



                  !readyToHit ? Center(child: CircularProgressIndicator(),) :  GenButton(
                    text: "Submit",
                    ontap: () {
                      MasukanBuktiTf(id, _image);
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


  void MasukanBuktiTf(id,gambar1) async {

    setState(() {
      readyToHit = false;
    });

    String fileName = gambar1.path.split('/').last;

    if(gambar1 != null){
      dataBukti = await req
          .postApiAuth("transaksi/bukti/"+id.toString(),
          {
            "bukti": await MultipartFile.fromFile(gambar1.path, filename: fileName),
          });

      print(dataBukti);

      if(dataBukti == "berhasil"){
        toastShow("Bukti transfer berhasil dikirim", context, Colors.black);
        Navigator.popAndPushNamed(context, "home");
      }else{
        setState(() {
          readyToHit = true;
        });
        toastShow("Kesalahan pada server", context, Colors.black);
      }




      // Navigator.popAndPushNamed(context, "home");
    }else{
      setState(() {
        readyToHit = true;
      });
      toastShow("periksa lagi bukti transfermu", context, Colors.black);
    }

    print("DATA $dataBukti");
    print("length" + dataBukti.length.toString());
  }

}
